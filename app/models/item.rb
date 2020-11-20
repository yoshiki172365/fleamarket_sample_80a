class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :delivery_date
  belongs_to_active_hash :trading_status


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

end
