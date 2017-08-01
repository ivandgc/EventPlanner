class Occasion < ApplicationRecord
  belongs_to :term
  has_many :events, dependent: :destroy
  has_many :user_occasions, dependent: :destroy
  has_many :users, through: :user_occasions
  belongs_to :admin, class_name: 'User'  

  validates :title, presence: true
  validate :valid_end_term

  def valid_end_term
    if (!self.term.end_term || !self.term.start_term) || self.term.end_term <= self.term.start_term
      self.errors[:term] << "start/end must be valid"
    end
  end

end
