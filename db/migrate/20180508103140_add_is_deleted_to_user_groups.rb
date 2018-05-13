class AddIsDeletedToUserGroups < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :user_groups, :is_deleted
      add_column :user_groups, :is_deleted, :boolean, default: false
    end
  end
end
