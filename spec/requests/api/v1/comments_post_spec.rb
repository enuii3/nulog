require 'rails_helper'

RSpec.describe 'CommentsApiPost', type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:user) { FactoryBot.create(:user) }
  let(:article) { FactoryBot.create(:article) }
  let(:user_comment) { { body: 'sample body', commenter_name: user.name, user_id: user.id, article_id: article.id } }
  let(:guest_comment) { { body: 'sample body', commenter_name: 'guest comment', user_id: nil, article_id: article.id } }

  describe 'PostApi' do
    it 'post guest comments' do
      post '/api/v1/comments', params: { comment: guest_comment }

      expect(response.status).to eq(200)
      expect(json['body']).to eq('sample body')
      expect(json['commenter_name']).to eq('guest comment')
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
    # エラーに関するスペックは別PRにて対応します。

    it 'raise in post expected error response ' do
      allow(Comment).to receive(:new).and_raise
      post '/api/v1/comments/', params: { comment: user_comment }

      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(500)
    end
  end
end
