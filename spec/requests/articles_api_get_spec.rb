require 'rails_helper'

RSpec.describe 'ArticlesApiGet', type: :request do
  let(:article) { FactoryBot.create(:article) }

  describe 'GetApi' do
    it 'success index article' do
      FactoryBot.create_list(:article, 3)

      get api_v1_articles_path
      json = JSON.parse(response.body)

      json.map do |j|
        expect(j.keys).to include('id', 'title', 'body', 'updated_at', 'user_name')
      end
      expect(json.length).to eq(3)
      expect(response.status).to eq(200)
    end

    it 'success show article' do
      get api_v1_article_path(article.id)
      json = JSON.parse(response.body)

      expect(json.keys).to include('id', 'title', 'body', 'updated_at', 'user_name')
      expect(json['title']).to eq(article.title)
      expect(response.status).to eq(200)
    end
  end
end
