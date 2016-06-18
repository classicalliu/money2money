class AddMessageToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :message, :text, default: ''
  end
end
