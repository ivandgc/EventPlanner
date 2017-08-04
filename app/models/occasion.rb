class Occasion < ApplicationRecord
  include ActiveModel::Validations
  
  belongs_to :term
  has_many :events, dependent: :destroy
  has_many :user_occasions, dependent: :destroy
  has_many :users, through: :user_occasions
  belongs_to :admin, class_name: 'User'

  validates :title, presence: true
  validates_with TermValidator
end
