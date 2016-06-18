class AddReturnMoneyToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :return_money, :jsonb, default: '[]'
  end
end
