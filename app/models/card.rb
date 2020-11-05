class Card < ApplicationRecord
  # pay.jpのためにview側でid付与のために、アクティブハッシュをコメントアウト

  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :birth_year
  # belongs_to_active_hash :card_validity_year

  # validates :birth_year, :card_validity_year, presence: true
  # validates :birth_year_id, numericality: { other_than: 0}
  # validates :card_validity_year_id, numericality: { other_than: 0}

  belongs_to :user

  validates :user_id, :customer_id, :card_id, presence: true
  validates :user_id, uniqueness: true

end
