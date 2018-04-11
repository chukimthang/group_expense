class RemoveProductIdToExpenses < ActiveRecord::Migration[5.1]
  def change
    if column_exists? :expenses, :product_id
      remove_column :expenses, :product_id
    end
  end
end
