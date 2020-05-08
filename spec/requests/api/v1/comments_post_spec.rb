require 'rails_helper'

RSpec.describe 'CommentsApiPost', type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:user) { FactoryBot.create(:user) }
  let(:article) { FactoryBot.create(:article) }
  let(:user_comment) { { commenter_name: user.name, body: 'sample body', user_id: user.id, article_id: article.id } }
  let(:guest_comment) { { commenter_name: 'guest', body: 'sample body', user_id: nil, article_id: article.id } }

  describe 'PostApi' do
    it 'post guest comments' do
      post '/api/v1/comments', params: { comment: guest_comment }

      expect(response.status).to eq(200)
      expect(json['commenter_name']).to eq('guest')
      expect(json['body']).to eq('sample body')
      expect(json['user_id']).to eq(nil)
      expect(json['article_id']).to eq(article.id)
    end

    it 'post user comments' do
      post '/api/v1/comments', params: { comment: user_comment }

      expect(json['commenter_name']).to eq(user.name)
      expect(json['user_id']).to eq(user.id)
    end
  end

  describe 'ErrorGetApi' do
    it 'empty commenter_name and null user_id expected validation errors' do
      guest_comment[:commenter_name] = ''
      post '/api/v1/comments', params: { comment: guest_comment }

      expect(json).to include('コメント投稿者を入力してください')
      expect(response.status).to eq(422)
    end

    it 'empty body expected validation errors' do
      guest_comment[:body] = ''
      post '/api/v1/comments', params: { comment: guest_comment }

      expect(json).to include('コメント本文を入力してください')
      expect(response.status).to eq(422)
    end

    it 'empty article_id expected validation errors' do
      guest_comment[:article_id] = ''
      post '/api/v1/comments', params: { comment: guest_comment }

      expect(json).to include('コメントしたい記事を入力してください')
      expect(response.status).to eq(422)
    end

    it 'raise in post expected error response ' do
      allow(Comment).to receive(:new).and_raise
      post '/api/v1/comments/', params: { comment: user_comment }

      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(500)
    end
  end
end
