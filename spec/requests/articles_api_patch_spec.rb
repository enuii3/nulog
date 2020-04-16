require 'rails_helper'

RSpec.describe 'ArticlesApiPatch', type: :request do
  let(:article) { FactoryBot.create(:article) }
  let(:json) { JSON.parse(response.body) }

  describe 'PatchApi' do
    it 'update article title' do
      patch "/api/v1/articles/#{article.id}", params: { article: { title: 'update-title' } }

      expect(json.keys).to include('title', 'body')
      expect(json['title']).to eq('update-title')
      expect(response.status).to eq(200)
    end

    it 'update article body' do
      patch "/api/v1/articles/#{article.id}", params: { article: { body: 'update-body' } }

      expect(json.keys).to include('title', 'body')
      expect(json['body']).to eq('update-body')
      expect(response.status).to eq(200)
    end
  end

  describe 'AnomaryPatchApi' do
    it 'no title' do
      patch "/api/v1/articles/#{article.id}", params: { article: { title: '' } }
    
      expect(json).to include('記事タイトルを入力してください')
      expect(response.status).to eq(422)
    end

    it 'no body' do
      patch "/api/v1/articles/#{article.id}", params: { article: { body: '' } }
    
      expect(json).to include('記事本文を入力してください')
      expect(response.status).to eq(422)
    end
  end
end
