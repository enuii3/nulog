require 'rails_helper'

RSpec.describe 'ArticlesApiDelete', type: :request do
  let!(:article) { FactoryBot.create(:article) }

  describe 'ApiDelete' do
    it 'delete articles/:id' do
      expect { delete "/api/v1/articles/#{article.id}" }.to change(Article, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end
