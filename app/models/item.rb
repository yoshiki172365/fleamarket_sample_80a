class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :delivery_date

  belongs_to :user
  belongs_to :category
  #一旦コメントアウト
  # belongs_to :purchase
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true, length: {maximum: 40}
  validates :description, presence: true, length: {maximum: 1000}
  validates :category_id, presence: true
  validates :status_id, presence: true, numericality: { other_than: 0 }
  validates :delivery_charge_id, presence: true, numericality: { other_than: 0 }
  validates :prefecture_id, presence: true, numericality: { other_than: 0 }
  validates :delivery_date_id, presence: true, numericality: { other_tnan: 0 }
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}

  validates :images, length: {minimum: 1}

  validates :user_id, presence: true
  validates :trading_status, numericality: { greater_than_or_equal_to: 1 }




#activehashに変更のために一度コメントアウト
  # enum status: {
  #   status_sentaku:0,
  #   shinpin:1,
  #   hobomishi:2,
  #   kizunahi:3,
  #   yayakizuari:4,
  #   kizuari:5
  # }

  # enum delivery_charge: {
  #   delivery_charge_sentaku:0,
  #   seller:1,
  #   buyer:2
  # }

  # enum delivery_date: {
  #   delivery_date_sentaku:0,
  #   until_two_days:1,
  #   until_three_days:2,
  #   until_seven_days:3
  # }

  # enum trading_status: {
  #   trading_sentaku:0,
  #   sale:1,
  #   sold:2
  # }
end
