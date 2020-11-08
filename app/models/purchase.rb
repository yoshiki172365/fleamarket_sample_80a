class Purchase < ApplicationRecord
  belongs_to :user
  #一旦コメントアウト
  # belongs_to :item
end
