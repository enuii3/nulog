require 'rails_helper'

RSpec.describe 'ArticlesApiPatch', type: :request do
  let(:article) { FactoryBot.create(:article) }
  let(:json) { JSON.parse(response.body) }

  describe 'PatchApi' do
    it 'update article title' do
      patch "/api/v1/articles/#{article.id}", params: { article: { title: 'update-title' } }

      expect(json['title']).to eq('update-title')
      expect(json['body']).to eq(article.body)
      expect(response.status).to eq(200)
    end

    it 'update article body' do
      patch "/api/v1/articles/#{article.id}", params: { article: { body: 'update-body' } }

      expect(json['title']).to eq(article.title)
      expect(json['body']).to eq('update-body')
      expect(response.status).to eq(200)
    end
  end
end
