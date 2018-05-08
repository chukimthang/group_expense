class AddCreateByUserToGroups < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :groups, :create_by_user
      add_column :groups, :create_by_user, :integer, null: false
    end
  end
end
