class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  validates :prefecture, presence: true
  validates :prefecture_id, numericality: { other_than: 0 }
end
