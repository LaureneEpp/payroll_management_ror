class CreatePositions < ActiveRecord::Migration[7.1]
  def change
    create_table :positions do |t|
      t.string :name
      t.boolean :manager

      t.timestamps
    end
  end
end
