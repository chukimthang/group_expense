class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.float :price, null: false
      t.text :description, null: true
      t.integer :product_id, default: 0
      t.integer :category_id, default: 0
      t.integer :group_id, default: 0

      t.timestamps
    end
  end
end
