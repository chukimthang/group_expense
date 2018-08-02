class CreateProductCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :product_categories do |t|
    	t.string :name, null: false
      t.integer :parent_id
    end
  end
end
