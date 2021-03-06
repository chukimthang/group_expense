class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions, mysql_options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.float :amount, null: false
      t.text :description
      t.integer :category_id, default: 0
      t.integer :group_id, default: 0
      t.integer :type_id, default: 1
      t.integer :user_id, default: 0
      t.timestamps
    end
  end
end
