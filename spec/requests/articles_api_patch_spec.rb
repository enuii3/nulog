require 'rails_helper'

RSpec.describe 'ArticlesApiPatch', type: :request do
  let(:article) { FactoryBot.create(:article) }

  describe 'PatchApi' do
    it 'success update article' do
      patch "/api/v1/articles/#{article.id}", params: { article: { title: 'update' } }
      json = JSON.parse(response.body)

      expect(json.keys).to include('title', 'body')
      expect(json['title']).to eq('update')
      expect(response.status).to eq(200)
    end
  end
end
