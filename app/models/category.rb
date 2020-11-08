class Category < ApplicationRecord
  has_ancestry
  has_many :items
<<<<<<< HEAD

  validates :name, presence: true
=======
>>>>>>> origin
end
