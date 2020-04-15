require 'rails_helper'

RSpec.describe 'ArticlesApiGet', type: :request do
  let(:article) { FactoryBot.create(:article) }
  let(:articles) { FactoryBot.create_list(:article, 3) }

  describe 'GetApi' do
    it 'index articles' do
      articles.map do |art|
        get api_v1_article_path(art.id)
        json = JSON.parse(response.body)
        art_updated_at = I18n.l(art.updated_at.to_date, format: :long)

        expect(json.keys).to include('id', 'title', 'body', 'updated_at', 'user_name')
        expect(json['id']).to eq(art.id)
        expect(json['title']).to eq(art.title)
        expect(json['body']).to eq(art.body)
        expect(json['updated_at']).to eq(art_updated_at)
        expect(json['user_name']).to eq(art.user.name)
        expect(response.status).to eq(200)
      end
    end

    it 'show article' do
      get api_v1_article_path(article.id)
      json = JSON.parse(response.body)
      article_updated_at = I18n.l(article.updated_at.to_date, format: :long)

      expect(json.keys).to include('id', 'title', 'body', 'updated_at', 'user_name')
      expect(json['id']).to eq(article.id)
      expect(json['title']).to eq(article.title)
      expect(json['body']).to eq(article.body)
      expect(json['updated_at']).to eq(article_updated_at)
      expect(json['user_name']).to eq(article.user.name)
      expect(response.status).to eq(200)
    end
  end
end
