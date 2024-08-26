class DropTables < ActiveRecord::Migration[7.1]
  def change
    drop_table(:payslips)
    drop_table(:deductions)
    drop_table(:allowances)
  end
end
