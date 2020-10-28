class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :email, null:false
      t.string :encrypted_password, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :first_name_kana, null: false
      t.string :last_name_kana, null: false
      t.integer :birth_year, null: false
      t.integer :birth_month, null: false
      t.integer :birth_day, null: false
      t.integer :phone_number, null: false, unique: true
      t.string :introduction
      t.string :icon_image
      t.timestamps
    end
  end
end
