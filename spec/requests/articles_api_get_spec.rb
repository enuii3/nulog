require 'rails_helper'

RSpec.describe 'ArticlesApiGet', type: :request do
  let(:article) { FactoryBot.create(:article) }
  let(:json) { JSON.parse(response.body) }

  describe 'GetApi' do
    it 'index articles' do
      FactoryBot.create_list(:article, 3)

      get api_v1_articles_path

      json.map do |j|
        expect(j.keys).to include('id', 'title', 'body', 'updated_at', 'user_name')
      end
      expect(json.length).to eq(3)
      expect(response.status).to eq(200)
    end

    it 'show article' do
      get api_v1_article_path(article.id)

      expect(json.keys).to include('id', 'title', 'body', 'updated_at', 'user_name')
      expect(json['title']).to eq(article.title)
      expect(response.status).to eq(200)
    end
  end

  describe 'AnomaryGetApi' do
    it 'show not find article' do
      get "/api/v1/articles/#{Article.count + 1}"

      expect(json).to include("message" => "エラーが発生しました。システム管理者にお問い合わせください。")
      expect(response.status).to eq(500)
    end
  end
end
