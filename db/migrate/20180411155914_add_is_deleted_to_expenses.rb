class AddIsDeletedToExpenses < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :expenses, :is_deleted
      add_column :expenses, :is_deleted, :boolean, default: false
    end
  end
end
