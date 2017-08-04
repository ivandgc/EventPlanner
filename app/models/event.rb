class Event < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :occasion
  belongs_to :term
  belongs_to :admin, class_name: 'User'
  has_many :user_events, dependent: :destroy

  validates :name, presence: true
  validates_with TermValidator

end
