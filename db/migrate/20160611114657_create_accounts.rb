class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user
      t.decimal :mount, precision: 8, scale: 2, default: 0

      t.timestamps null: false
    end
  end
end
