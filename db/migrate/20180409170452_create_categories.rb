class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories, mysql_options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
