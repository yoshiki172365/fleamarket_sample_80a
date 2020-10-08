class CreateAdresses < ActiveRecord::Migration[6.0]
  def change
    create_table :adresses do |t|
      t.string      :zip_code, null: false
      t.references  :prefecture_id, null: false, foreign_key: true
      t.string      :city, null: false
      t.string      :block_number, null: false
      t.string      :apartment_name
      t.references  :user_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
