class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birth_year
  validates :birth_year_id, numericality: { other_than: 0 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birth_month
  validates :birth_month_id, numericality: { other_than: 0 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birth_day
  validates :birth_day_id, numericality: { other_than: 0 }
end
