require 'rails_helper'

RSpec.describe 'ArticlesApiPost', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:json) { JSON.parse(response.body) }

  describe 'ApiPost' do
    it 'create article' do
      valid_params = { title: 'test-title', body: 'test-body', user_id: user.id }

      expect { post '/api/v1/articles/', params: { article: valid_params } }.to change(Article, :count).by(+1)
      expect(json.keys).to include('id', 'title', 'body', 'updated_at', 'user_id')
      expect(response.status).to eq(200)
    end
  end

  describe 'AnomayApiPost' do
    it 'no title' do
      valid_params = { title: '', body: 'test-body', user_id: user.id }
      post '/api/v1/articles/', params: { article: valid_params }
      expect(json).to include('記事タイトルを入力してください')
      expect(response.status).to eq(422)
    end

    it 'no body' do
      valid_params = { title: 'test-title', body: '', user_id: user.id }
      post '/api/v1/articles/', params: { article: valid_params }
      expect(json).to include('記事本文を入力してください')
      expect(response.status).to eq(422)
    end

    it 'no title and body' do
      valid_params = { title: '', body: '', user_id: user.id }
      post '/api/v1/articles/', params: { article: valid_params }
      expect(json).to include('記事タイトルを入力してください', '記事本文を入力してください')
      expect(response.status).to eq(422)
    end

    it 'no user_id' do
      valid_params = { title: 'test-title', body: 'test-body', user_id: '' }
      post '/api/v1/articles/', params: { article: valid_params }

      # ユーザーIDがなかった場合に500エラーを返す修正を後日対応
      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(500)
    end
  end
end
