class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  validates :prefecture, presence: true
  validates :prefecture_id, numericality: { other_than: 0 }

  enum condition: [:condition_sentaku, :shinpin, :hobomishi, :kizunahi, :yayakizuari, :kizuari]
  enum delivery_fee: [:delivery_fee_sentaku, :seller, :buyer]
  enum shipping_day: [:shipping_day_sentaku, :until_two_days, :until_three_days, :until_seven_days]

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
end
