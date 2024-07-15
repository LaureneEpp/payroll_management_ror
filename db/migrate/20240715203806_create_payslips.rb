class CreatePayslips < ActiveRecord::Migration[7.1]
  def change
    create_table :payslips do |t|

      t.timestamps
    end
  end
end
