class UserEvent < ActiveRecord::Base
  belongs_to :user_occasion
  belongs_to :event

end
