require 'rails_helper'

RSpec.describe 'ArticlesApiGet', type: :request do
  let(:article) { FactoryBot.create(:article) }
  let(:articles) { FactoryBot.create_list(:article, 2) }
  let(:articles_with_comments) { FactoryBot.create_list(:article, 3, :with_comments) }

  describe 'GetApi' do
    it 'index articles with no comments' do
      articles
      get '/api/v1/articles/'
      jsons = JSON.parse(response.body)

      jsons.each do |json|
        expect(json.keys).to include('id', 'title', 'body', 'updated_at', 'user_name', 'comments_count')
        expect(json['comments_count']).to eq(0)
      end
      expect(response.status).to eq(200)
      expect(jsons.length).to eq(2)
    end

    it 'index articles with 2 comments' do
      articles_with_comments
      get '/api/v1/articles/'
      jsons = JSON.parse(response.body)

      jsons.each do |json|
        expect(json['comments_count']).to eq(2)
      end
    end

    it 'show article' do
      get "/api/v1/articles/#{article.id}"
      json = JSON.parse(response.body)
      article_updated_at = I18n.l(article.updated_at.to_date, format: :long)

      expect(json['title']).to eq(article.title)
      expect(json['body']).to eq(article.body)
      expect(json['updated_at']).to eq(article_updated_at)
      expect(json['user_name']).to eq(article.user.name)
      expect(response.status).to eq(200)
    end
  end

  describe 'ErrorGetApi' do
    it 'not found artilce expected error response' do
      get '/api/v1/articles/undefined'
      json = JSON.parse(response.body)

      expect(json).to include('message' => 'お探しものが見つかりません')
      expect(response.status).to eq(404)
    end

    it 'raise in index expected error response' do
      articles
      allow(Article).to receive(:all).and_raise
      get '/api/v1/articles/'
      json = JSON.parse(response.body)

      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(500)
    end

    it 'raise in show expected error response' do
      allow(Article).to receive(:find).and_raise
      get "/api/v1/articles/#{article.id}"
      json = JSON.parse(response.body)

      expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
      expect(response.status).to eq(500)
    end
  end
end
