class AddAlreadyPayToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :already_pay, :decimal, precision: 8, scale: 2, default: 0
    add_column :loans, :should_return, :decimal, precision: 8, scale: 2, default: 0
  end
end
