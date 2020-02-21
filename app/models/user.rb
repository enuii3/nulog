class User < ApplicationRecord
  devise :database_authenticatable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite, as: :favoriteable, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
end
