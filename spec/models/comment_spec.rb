require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment){FactoryBot.create(:comment)}

  #ユーザーIDがないとコメントできない
  #it 'is invalid without user_id' do
  #  comment.update(user: nil)
  #  comment.valid?
  #  expect(comment.errors[:user_id]).to include("")
  #end

  #1000文字以上のbodyはコメントできない
  it 'is invalid body 1000 over strings' do
    comment.update(body: "1yreve thgin doog ,gnineve doog ,noonretfa doog ,gninrom doog ,hcum yrev uoy knaht ,uoy teem ot eciN" * 6)
    comment.valid?
    expect(comment.errors[:body]).to include("is too long (maximum is 1000 characters)")
  end
end
