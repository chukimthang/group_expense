class CreateDataFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :data_files do |t|
      t.string :file_name
      t.string :file_path, null: false
      t.integer :user_id, default: 0
      t.integer :group_id, default: 0
      t.integer :type_action_id, default: 0

      t.timestamps
    end
  end
end
