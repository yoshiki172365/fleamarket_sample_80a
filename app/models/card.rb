class Card < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birth_year
  belongs_to_active_hash :card_validity_year

  validates :birth_year, :card_validity_year, presence: true
  validates :birth_year_id, numericality: { other_than: 0}
  validates :card_validity_year_id, numericality: { other_than: 0}

end
