class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string        :name, null: false
      t.string        :description, null: false
      t.references    :category, null: false
      t.string        :brand
      t.integer       :status, null: false
      t.integer       :delivery_charge, null: false
      t.integer       :prefecture_id, null: false
      t.integer       :delivery_date, null: false
      t.integer       :price, null: false

      t.timestamps
    end
  end
end
