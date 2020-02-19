require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { FactoryBot.create(:article) }

  it 'is valid with title, and body' do
    expect(article).to be_valid
  end

  it 'is invalid without title' do
    article.update(title: nil)
    expect(article).to be_invalid
  end

  it 'is invalid without body' do
    article.update(body: nil)
    expect(article).to be_invalid
  end
end
