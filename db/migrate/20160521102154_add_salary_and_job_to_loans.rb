class AddSalaryAndJobToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :salary, :decimal, precision: 8, scale: 2
    add_column :loans, :job, :string
    add_column :loans, :company_add, :string
  end
end
