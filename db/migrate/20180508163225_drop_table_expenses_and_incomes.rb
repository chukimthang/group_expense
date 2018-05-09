class DropTableExpensesAndIncomes < ActiveRecord::Migration[5.1]
  def up
    drop_table(:expenses, if_exists: true)
    drop_table(:incomes, if_exists: true)
  end
end
