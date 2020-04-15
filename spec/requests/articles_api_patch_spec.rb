require 'rails_helper'

RSpec.describe 'ArticlesApiPatch', type: :request do
  let(:article) { FactoryBot.create(:article) }

  describe 'PatchApi' do
    it 'patch articles/:id' do
      patch "/api/v1/articles/#{article.id}", params: { article: { title: 'update' } }
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['title']).to eq('update')
    end
  end
end
