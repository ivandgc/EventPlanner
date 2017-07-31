class UserOccasion < ApplicationRecord
  belongs_to :user
  belongs_to :occasion
end
