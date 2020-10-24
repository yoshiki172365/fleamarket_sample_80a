class CreateAddersses < ActiveRecord::Migration[6.0]
  def change
    create_table :addersses do |t|

      t.timestamps
    end
  end
end
