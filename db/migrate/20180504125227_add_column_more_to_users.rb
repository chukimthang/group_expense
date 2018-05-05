class AddColumnMoreToUsers < ActiveRecord::Migration[5.1]
  def change
    unless column_exists? :users, :full_name
      add_column :users, :full_name, :string
    end
    unless column_exists? :users, :birthday
      add_column :users, :birthday, :datetime
    end
    unless column_exists? :users, :description
      add_column :users, :description, :text
    end
    unless column_exists? :users, :avatar
      add_column :users, :avatar, :string
    end
  end
end
