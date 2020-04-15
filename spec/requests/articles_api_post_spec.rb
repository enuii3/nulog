require 'rails_helper'

RSpec.describe 'ArticlesApiPost', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:json) { JSON.parse(response.body) }

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
end
