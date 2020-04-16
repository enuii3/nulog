require 'rails_helper'

RSpec.describe 'ArticlesApiPost', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'ApiPost' do
    it 'success show article' do
      valid_params = { title: 'test-title', body: 'test-body', user_id: user.id }

      expect { post '/api/v1/articles/', params: { article: valid_params } }.to change(Article, :count).by(+1)
      json = JSON.parse(response.body)
      expect(json.keys).to include('id', 'title', 'body', 'updated_at', 'user_id')
      expect(response.status).to eq(200)
    end
  end
end
