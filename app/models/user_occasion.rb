class UserOccasion < ApplicationRecord
  belongs_to :user
  belongs_to :occasion
  has_many :user_events, dependent: :destroy

end
