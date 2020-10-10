class Card < ApplicationRecord
  validates :prive, presence: true
  belongs_to :user
end
