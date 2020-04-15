require 'rails_helper'

RSpec.describe 'ArticlesApiGet', type: :request do
  let(:article) { FactoryBot.create(:article) }

  describe 'GetApi' do
    it 'get articles/' do
      FactoryBot.create_list(:article, 3)

      get api_v1_articles_path
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json.length).to eq(3)
    end

    it 'get articles/:id' do
      get api_v1_article_path(article.id)
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['title']).to eq(article.title)
    end
  end
end
