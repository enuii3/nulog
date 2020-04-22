require 'rails_helper'

RSpec.describe 'ArticlesApiDelete', type: :request do
  let!(:article) { FactoryBot.create(:article) }

  describe 'ApiDelete' do
    it 'destroy article' do
      expect { delete "/api/v1/articles/#{article.id}" }.to change(Article, :count).by(-1)
      expect(response.status).to eq(200)
    end
  end

  describe 'ErrorApiDelete' do
    it 'not found article expected error response' do
      delete '/api/v1/articles/1'
      json = JSON.parse(response.body)

      expect(json).to include('message' => 'お探しものが見つかりません')
      expect(response.status).to eq(404)
    end

    it 'raise in destroy expected error response' do
      allow_any_instance_of(Article).to receive(:destroy).and_raise
      delete "/api/v1/articles/#{article.id}"
      json = JSON.parse(response.body)

      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(500)
    end
  end
end
