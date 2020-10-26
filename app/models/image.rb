class Image < ApplicationRecord
  mount_uploader :image_src, ImageUploader
  belongs_to :item
end
