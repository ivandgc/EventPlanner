class Event < ApplicationRecord
  belongs_to :occasion
  belongs_to :term
  belongs_to :admin, class_name: 'User'
  has_many :user_events, dependent: :destroy



end
