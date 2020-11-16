class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :first_name,       null: false
      t.string :last_name,        null: false
      t.string :first_name_kana,  null: false
      t.string :last_name_kana,   null: false
      t.string :zip_code,         null: false
      t.integer :prefecture_id,   null: false
      t.string :city,             null: false
      t.string :block_number,     null: false
      t.string :apartment_name
      t.references :user,         null: false, foreign_key: true
      t.string :phone_number,     null: false
      t.timestamps
    end
  end
end
