class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references :item, null:false, foreign_key:true
      t.references :user, null:false, foreign_key:true
      t.integer :paymet_way_id, null:false
      t.integer :prefecture_id, null:false
      t.integer :paymet_status_id, null:false
      t.integer :shipping_status_id, null:false
      t.integer :delivery_status_id, null:false
      t.timestamps
    end
  end
end
