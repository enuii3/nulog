require 'rails_helper'

RSpec.describe 'ArticlesApiGet', type: :request do
  let(:article) { FactoryBot.create(:article) }
  let(:articles) { FactoryBot.create_list(:article, 3) }

  describe 'GetApi' do
    it 'index articles' do
      articles
      get api_v1_articles_path
      jsons = JSON.parse(response.body)

      jsons.each do |json|
        expect(json.keys).to include('id', 'title', 'body', 'updated_at', 'user_name')
      end
      expect(jsons.length).to eq(3)
      expect(response.status).to eq(200)
    end

    it 'show article' do
      get api_v1_article_path(article.id)
      json = JSON.parse(response.body)
      article_updated_at = I18n.l(article.updated_at.to_date, format: :long)

      expect(json['id']).to eq(article.id)
      expect(json['title']).to eq(article.title)
      expect(json['body']).to eq(article.body)
      expect(json['updated_at']).to eq(article_updated_at)
      expect(json['user_name']).to eq(article.user.name)
      expect(response.status).to eq(200)
    end
  end
end
