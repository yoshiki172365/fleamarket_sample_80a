class Card < ApplicationRecord
  validates :user_id, :customer_id,  presence: true

  belongs_to :user
end
