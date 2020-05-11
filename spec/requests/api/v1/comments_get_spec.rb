require 'rails_helper'

RSpec.describe 'コメントAPIのGETリクエスト', type: :request do
  let(:article) { FactoryBot.create(:article) }

  describe 'コメント一覧の描画に関する正常系スペック' do
    context '匿名ユーザーの場合' do
      it '値が正しい事' do
        guest_comments = FactoryBot.create_list(:comment, 2, article: article)
        get '/api/v1/comments', params: { article_id: article.id, limit: 5, offset: 0 }
        json = JSON.parse(response.body)

        expect(json.length).to eq(2)
        expect(response.status).to eq(200)
        expect(json.first['id']).to eq(guest_comments.last.id)
        expect(json.first['body']).to eq(guest_comments.last.body)
        expect(json.first['commenter_name']).to eq(guest_comments.last.commenter_name)
      end

      context 'さらに表示ボタンが押された場合' do
        it '50件のコメントに対して表示件数が正しい事' do
          FactoryBot.create_list(:comment, 50, article: article)
          get '/api/v1/comments', params: { article_id: article.id, limit: 5, offset: 0 }
          json = JSON.parse(response.body)

          expect(json.length).to eq(5)

          get '/api/v1/comments', params: { article_id: article.id, limit: 15, offset: 5 }
          json = JSON.parse(response.body)

          expect(json.length).to eq(15)

          get '/api/v1/comments', params: { article_id: article.id, limit: 20, offset: 20 }
          json = JSON.parse(response.body)

          expect(json.length).to eq(20)

          get '/api/v1/comments', params: { article_id: article.id, limit: 20, offset: 40 }
          json = JSON.parse(response.body)

          expect(json.length).to eq(10)
        end
      end
    end

    context 'ユーザーの場合' # 後日追加
  end

  describe 'コメント一覧の描画に関する異常系スペック' do
    let(:guest_comment) { FactoryBot.create(:comment, article: article) }

    context '匿名ユーザーの場合' do
      it 'パラメーターが空だった場合に空の配列が返る事' do
        guest_comment
        get '/api/v1/comments', params: {}
        json = JSON.parse(response.body)

        expect(json).to eq([])
      end

      it 'article_idが空だった場合に空の配列が返る事' do
        guest_comment
        get '/api/v1/comments', params: { article_id: nil, limit: 5, offset: 0 }
        json = JSON.parse(response.body)

        expect(json).to eq([])
      end

      it 'limitが空だった場合に空の配列が返る事' do
        guest_comment
        get '/api/v1/comments', params: { article_id: article.id, limit: nil, offset: 0 }
        json = JSON.parse(response.body)

        expect(json).to eq([])
      end

      it 'offsetが空だった場合にが降順ではない事' do
        guest_comments = FactoryBot.create_list(:comment, 3, article: article)
        get '/api/v1/comments', params: { article_id: article.id, limit: 5, offset: nil }
        json = JSON.parse(response.body)

        expect(json.first['id']).to eq(guest_comments.last.id)
      end
    end

    context 'ユーザーの場合' # 後日追加

    context '例外の場合' do
      it '500が返る事' do
        guest_comment
        allow(Comment).to receive(:where).and_raise
        get '/api/v1/comments/'
        json = JSON.parse(response.body)

        expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
        expect(response.status).to eq(500)
      end
    end
  end
end
