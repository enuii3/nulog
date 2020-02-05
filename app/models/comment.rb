class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_many :favorite, as: :favoriteable, dependent: :destroy
  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 10 }
end
