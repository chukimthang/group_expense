class AddIsDeletedToUsers < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :users, :is_deleted
      add_column :users, :is_deleted, :boolean, default: false
    end
  end
end
