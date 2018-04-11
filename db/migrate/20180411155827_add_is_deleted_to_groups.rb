class AddIsDeletedToGroups < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :groups, :is_deleted
      add_column :groups, :is_deleted, :boolean, default: false
    end
  end
end
