class AddPassedToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :passed, :string, default: 'no'
  end
end
