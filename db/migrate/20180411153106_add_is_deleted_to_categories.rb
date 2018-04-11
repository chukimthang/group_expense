class AddIsDeletedToCategories < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :categories, :is_deleted
      add_column :categories, :is_deleted, :boolean, default: false
    end
  end
end
