class Favorite < ApplicationRecord
  belongs_to :favoriteable, polymorphic: true
  belongs_to :user
  validates :user_id
end
