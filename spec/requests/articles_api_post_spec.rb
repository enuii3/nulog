require 'rails_helper'

RSpec.describe 'ArticlesApiPost', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'ApiPost' do
    it 'post articles/:id' do
      valid_params = { id: Article.count + 1, title: 'test-title', body: 'test-body', user_id: user.id }

      expect { post '/api/v1/articles/', params: { article: valid_params } }.to change(Article, :count).by(+1)
      expect(response.status).to eq(200)
    end
  end
end
