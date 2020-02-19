require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }
  let(:user) { FactoryBot.create(:user) }

  it 'is valid with a body, and an user' do
    comment.update(user_id: user.id)
    expect(comment).to be_valid
  end

  it 'is valid without a user' do
    expect(comment).to be_valid
  end

  it 'is invalid without a body' do
    comment.update(user_id: user.id, body: nil)
    expect(comment).to be_invalid
  end
end
