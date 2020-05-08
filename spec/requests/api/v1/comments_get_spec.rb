require 'rails_helper'

RSpec.describe 'CommentsApiGet', type: :request do
  let(:article) { FactoryBot.create(:article) }

  describe 'GetApi' do
    it 'index guest comments' do
      guest_comments = FactoryBot.create_list(:comment, 50, article: article)
      get '/api/v1/comments', params: { article_id: article.id, limit: 5, offset: 0 }
      json = JSON.parse(response.body)
      guest_comments.sort! { |a, b| b.updated_at <=> a.updated_at }

      expect(json.length).to eq(5)
      expect(response.status).to eq(200)
      expect(json.first['id']).to eq(guest_comments.first.id)
      expect(json.first['body']).to eq(guest_comments.first.body)
      expect(json.first['commenter_name']).to eq(guest_comments.first.commenter_name)

      guest_comments.shift(5)
      get '/api/v1/comments', params: { article_id: article.id, limit: 15, offset: 5 }
      json = JSON.parse(response.body)

      expect(json.length).to eq(15)
      expect(json.first['id']).to eq(guest_comments.first.id)

      guest_comments.shift(15)
      get '/api/v1/comments', params: { article_id: article.id, limit: 20, offset: 20 }
      json = JSON.parse(response.body)

      expect(json.length).to eq(20)

      guest_comments.shift(20)
      get '/api/v1/comments', params: { article_id: article.id, limit: 20, offset: 40 }
      json = JSON.parse(response.body)

      expect(json.length).to eq(10)
    end
  end

  describe 'ErrorGetApi' do
    let(:guest_comments) { FactoryBot.create_list(:comment, 2, article: article) }

    it 'is params empty expected empty array response' do
      guest_comments
      get '/api/v1/comments', params: {}
      json = JSON.parse(response.body)

      expect(json).to eq([])
      expect(response.status).to eq(200)
    end

    it 'is article_id nil expected empty array response' do
      guest_comments
      get '/api/v1/comments', params: { article_id: nil, limit: 5, offset: 0 }
      json = JSON.parse(response.body)

      expect(json).to eq([])
      expect(response.status).to eq(200)
    end

    it 'is limit nil expected empty array response' do
      guest_comments
      get '/api/v1/comments', params: { article_id: article.id, limit: nil, offset: 0 }
      json = JSON.parse(response.body)

      expect(json).to eq([])
      expect(response.status).to eq(200)
    end

    it 'is offset nil expected comments response' do
      guest_comments
      get '/api/v1/comments', params: { article_id: article.id, limit: 5, offset: nil }
      json = JSON.parse(response.body)

      expect(json.first['id']).to eq(guest_comments.last.id)
      expect(response.status).to eq(200)
    end

    it 'raise in index expected error response' do
      guest_comments
      allow(Comment).to receive(:where).and_raise
      get '/api/v1/comments/'
      json = JSON.parse(response.body)

      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(500)
    end
  end
end
