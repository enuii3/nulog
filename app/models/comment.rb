class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :article
  has_many :favorite, as: :favoriteable, dependent: :destroy
  validates :body, presence: true, length: { maximum: 1000 }
end
