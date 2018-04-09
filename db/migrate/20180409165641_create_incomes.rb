class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.float :amount_of_money, default: 0
      t.text :description, null: true
      t.integer :group_id, default: 0

      t.timestamps
    end
  end
end
