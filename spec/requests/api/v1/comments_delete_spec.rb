require 'rails_helper'

RSpec.describe 'CommentsApiDelete', type: :request do
  let!(:comment) { FactoryBot.create(:comment) }
  let(:json) { JSON.parse(response.body) }

  describe 'ApiDelete' do
    it 'destroy comment' do
      expect { delete "/api/v1/comments/#{comment.id}" }.to change(Comment, :count).by(-1)
      expect(response.status).to eq(200)
    end
  end

  describe 'ErrorApiDelete' do
    it 'not found comment expected error response' do
      delete '/api/v1/comments/undefined'

      expect(json).to include('message' => 'お探しものが見つかりません')
      expect(response.status).to eq(404)
    end

    it 'raise in destroy expected error response' do
      allow_any_instance_of(Comment).to receive(:destroy).and_raise
      delete "/api/v1/comments/#{comment.id}"

      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(500)
    end
  end
end
