class AddAccountToUsers < ActiveRecord::Migration
  def change
    # 累计投资
    add_column :users, :invest_count, :decimal, precision: 8, scale: 2, default: 0
    # 累计收益
    add_column :users, :profit_count, :decimal, precision: 8, scale: 2, default: 0
    # 待收收益
    add_column :users, :profit_not_yet, :decimal, precision: 8, scale: 2, default: 0
    # 冻结资金
    add_column :users, :frozen_capital, :decimal, precision: 8, scale: 2, default: 0
    # 待收资金
    add_column :users, :capital_not_yet, :decimal, precision: 8, scale: 2, default: 0
    # 可用资金
    add_column :users, :valid_capital, :decimal, precision: 8, scale: 2, default: 0
  end
end
