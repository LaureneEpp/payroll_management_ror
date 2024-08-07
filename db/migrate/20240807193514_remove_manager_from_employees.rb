class RemoveManagerFromEmployees < ActiveRecord::Migration[7.1]
  def change
    remove_column :employees, :manager, :boolean
  end
end
