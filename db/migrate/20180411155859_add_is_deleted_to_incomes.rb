class AddIsDeletedToIncomes < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :incomes, :is_deleted
      add_column :incomes, :is_deleted, :boolean, default: false
    end
  end
end
