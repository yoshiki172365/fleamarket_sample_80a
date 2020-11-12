class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  validates :prefectures, presence: true
  validates :prefectures, numericality: { other_than: 0 }
end
