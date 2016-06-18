class AddFulledToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :fulled, :boolean, default: false
  end
end
