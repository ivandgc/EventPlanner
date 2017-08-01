class User < ApplicationRecord
  has_many :user_occasions, dependent: :destroy
  has_many :occasions, through: :user_occasions
  has_many :occasions, foreign_key: 'admin_id'
  has_many :events, foreign_key: 'admin_id'
  has_secure_password

  validates :email, uniqueness: true
  validates :name, :email, :password, :password_confirmation, presence: true
end
