class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorite, as: :favoriteable, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 8 }
  validates :body, presence: true, length: { maximum: 10 }
end
