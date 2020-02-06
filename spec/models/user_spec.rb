require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){FactoryBot.create(:user)}

  #名前とメールアドレスとパスワードがあれば有効
  it 'is valid with name, email, and encrypted_password' do
    user.valid?
    expect(user).to be_valid
  end

  #名前が無ければ無効
  it 'is invalid without a name' do
    user.update(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  #メールアドレスが無ければ無効
  it 'is invalid without an email' do
    user.update(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  #パスワードが無ければ無効
  it 'is invalid without an encrypted_password' do
    user.update(encrypted_password: nil)
    user.valid?
    expect(user.errors[:encrypted_password]).to include("can't be blank")
  end

  #メールアドレスが重複していれば無効
  it 'is invalid with duplicate email' do
    user
    other = User.create(
      name: 'nakai',
      email: 'sample@hogehoge.com',
      encrypted_password: 'hogehoge',
    )
    other.valid?
    expect(other.errors.messages).to include("has already been taken")
  end
end
