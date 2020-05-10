require 'rails_helper'

RSpec.describe 'コメントAPIのPOSTリクエスト', type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:article) { FactoryBot.create(:article) }
  let(:guest_comment) { { commenter_name: 'guest', body: 'sample body', user_id: nil, article_id: article.id } }

  describe 'コメント作成に関する正常系スペック' do
    context '匿名ユーザーの場合' do
      it 'postリクエストが正常である事' do
        post '/api/v1/comments', params: { comment: guest_comment }

        expect(response.status).to eq(200)
        expect(json['commenter_name']).to eq('guest')
        expect(json['body']).to eq('sample body')
        expect(json['user_id']).to eq(nil)
        expect(json['article_id']).to eq(article.id)
      end
    end

    context 'ユーザーの場合' # 後日追加します
  end

  describe 'コメント作成に関する異常系スペック' do
    context '匿名ユーザーの場合' do
      it '投稿者名が空だった場合は422が返る事' do
        guest_comment[:commenter_name] = ''
        post '/api/v1/comments', params: { comment: guest_comment }

        expect(json).to include('コメント投稿者を入力してください')
        expect(response.status).to eq(422)
      end

      it 'コメント本文が空だった場合に422が返る事' do
        guest_comment[:body] = ''
        post '/api/v1/comments', params: { comment: guest_comment }

        expect(json).to include('コメント本文を入力してください')
        expect(response.status).to eq(422)
      end

      it 'article_idが空だった場合に422が返る事' do
        guest_comment[:article_id] = ''
        post '/api/v1/comments', params: { comment: guest_comment }

        expect(json).to include('記事を入力してください')
        expect(response.status).to eq(422)
      end
    end

    context 'ユーザーの場合' # 後日追加します

    context '例外の場合' do
      it '５００が返る事 ' do
        allow(Comment).to receive(:new).and_raise
        post '/api/v1/comments/', params: { comment: guest_comment }

        expect(json).to include('message' => 'エラーが発生しました。システム管理者にお問い合わせください。')
        expect(response.status).to eq(500)
      end
    end
  end
end
