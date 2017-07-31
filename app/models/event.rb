class Event < ApplicationRecord
  belongs_to :occasion
  belongs_to :term
end
