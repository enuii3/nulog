class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorite, as: :favoriteable, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 200 }
  validates :body, presence: true, length: { maximum: 2000 }
end
