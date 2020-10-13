class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :description, null:false
      t.integer :category, null:false, foreign_key:true
      t.integer :size, null: false
      t.string :brand
      t.integer :status, null: false
      t.integer :delivery_charge, null: false
      t.integer :delivery_way, null: false
      t.integer :prefecture, null: false
      t.integer :delivery_date, null: false
      t.integer :price, null: false
      t.integer :buyer, foreign_key: true
      t.integer :seller, null: false, foreign_key:true
      t.timestamps
    end
  end
end
