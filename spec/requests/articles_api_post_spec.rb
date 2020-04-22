require 'rails_helper'

RSpec.describe 'ArticlesApiPost', type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:user) { FactoryBot.create(:user) }

  describe 'ApiPost' do
    it 'create article' do
      valid_params = { title: 'test-title', body: 'test-body', user_id: user.id }

      expect { post '/api/v1/articles/', params: { article: valid_params } }.to change(Article, :count).by(+1)
      expect(json['title']).to eq('test-title')
      expect(json['body']).to eq('test-body')
      expect(json['user_id']).to eq(user.id)
      expect(response.status).to eq(200)
    end
  end

  describe 'ErrorApiPost' do
    it 'no title expected error response' do
      valid_params = { title: '', body: 'test-body', user_id: user.id }
      post '/api/v1/articles/', params: { article: valid_params }
      expect(json).to include('記事タイトルを入力してください')
      expect(response.status).to eq(422)
    end

    it 'no body expected error response' do
      valid_params = { title: 'test-title', body: '', user_id: user.id }
      post '/api/v1/articles/', params: { article: valid_params }
      expect(json).to include('記事本文を入力してください')
      expect(response.status).to eq(422)
    end

    it 'no user_id expected error response' do
      valid_params = { title: 'test-title', body: 'test-body', user_id: '' }
      post '/api/v1/articles/', params: { article: valid_params }

      expect(json).to include('Userを入力してください', 'Userを入力してください')
      expect(response.status).to eq(422)
    end

    it 'no propaty expected error response' do
      post '/api/v1/articles/', params: {}
      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(400)
    end

    it 'raise in create expected error response ' do
      valid_params = { title: 'test-title', body: 'test-body', user_id: user.id }
      allow(Article).to receive(:new).and_raise
      post '/api/v1/articles/', params: { article: valid_params }

      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(500)
    end
  end
end
