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

  describe 'ErrorPatchApi' do
    it 'no title expected error response' do
      patch "/api/v1/articles/#{article.id}", params: { article: { title: '' } }

      expect(json).to include('記事タイトルを入力してください')
      expect(response.status).to eq(422)
    end

    it 'no body expected error response' do
      patch "/api/v1/articles/#{article.id}", params: { article: { body: '' } }

      expect(json).to include('記事本文を入力してください')
      expect(response.status).to eq(422)
    end

    it 'no user_id expected error response' do
      patch "/api/v1/articles/#{article.id}", params: { article: { user_id: '' } }

      expect(json).to include('Userを入力してください', 'Userを入力してください')
      expect(response.status).to eq(422)
    end

    it 'no propaty expected error response' do
      patch "/api/v1/articles/#{article.id}", params: {}

      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(400)
    end

    it 'raise in update expected error response' do
      allow_any_instance_of(Article).to receive(:update).and_raise
      patch "/api/v1/articles/#{article.id}", params: { article: { title: 'update-title' } }

      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(500)
    end
  end
end
