class CreateAllowances < ActiveRecord::Migration[7.1]
  def change
    create_table :allowances do |t|
      t.string :name
      t.string :description
      t.integer :amount

      t.timestamps
    end
  end
end
