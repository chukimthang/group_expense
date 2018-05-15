class CreateUserGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_groups, mysql_options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.integer :user_id, default: 0
      t.integer :group_id, default: 0
      t.integer :user_admin_group_id, default: 0

      t.timestamps
    end
  end
end
