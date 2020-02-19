require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let(:other) { FactoryBot.create(:user) }

  it 'is valid with name, email, and password' do
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user.update(name: nil)
    expect(user).to be_invalid
  end

  it 'is invalid without an email' do
    user.update(email: nil)
    expect(user).to be_invalid
  end

  it 'is invalid without an encruypted_password' do
    user.update(encrypted_password: nil)
    expect(user).to be_invalid
  end

  it 'is invalid with duplicate email' do
    expect do
      other.update!(email: user.email)
    end.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
