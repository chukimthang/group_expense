class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.boolean :is_shared, default: false
      t.integer :category_id, default: 0
      t.integer :group_id, default: 0

      t.timestamps
    end
  end
end
