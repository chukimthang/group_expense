class RemoveUserAdminGroupIdToUserGroups < ActiveRecord::Migration[5.1]
  def change
    if column_exists? :user_groups, :user_admin_group_id
      remove_column :user_groups, :user_admin_group_id
    end
  end
end
