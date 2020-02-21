class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite, as: :favoriteable, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
end
