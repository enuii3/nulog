require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article){FactoryBot.create(:article)}

  #titleとbodyがあると有効
  it 'is valid with title and body' do
    article
    article.valid?
    expect(article).to be_valid
  end

  #titleがないと無効
  it 'is invalid without a title' do
    article.update(title: nil)
    article.valid?
    expect(article.errors[:title]).to include("can't be blank")
  end

  #bodyがないと無効
  it 'is invalid without a body' do
    article.update(body: nil)
    article.valid?
    expect(article.errors[:body]).to include("can't be blank")
  end

  #titleの文字数が201文字以上だと無効
  it 'is invalid title with 200 over strings' do
    article.update(title: "はじめまして、コンチにちは、おはようございます。おやすみなさい、こんばんわ、ありがとうございます！！" * 5)
    article.valid?
    expect(article.errors[:title]).to include("is too long (maximum is 200 characters)")
  end

  #bodyの文字数が2001文字以上だと無効
  it 'is invalid body with 2000 over strings' do
    article.update(body: "Nice to meet you, thank you very much, good morning, good afternoon, good evening, good night every1" * 21)
    article.valid?
    expect(article.errors[:body]).to include("is too long (maximum is 2000 characters)")
  end

  #user_idがないとArticleモデルを作成できない
  it 'is invalid without user_id' do
    article.update(user: nil)
    article.valid?
    expect(article.errors[:user_id]).to include("can't be blank")
  end
end
