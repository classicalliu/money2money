class AddAlreadyMountToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :already_mount, :decimal, precision: 8, scale: 2, default: 0
  end
end
