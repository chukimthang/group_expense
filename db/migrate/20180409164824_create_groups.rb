class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.float :saved_money, default: 0

      t.timestamps
    end
  end
end
