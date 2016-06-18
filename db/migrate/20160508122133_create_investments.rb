class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.decimal :mount, precision: 8, scale: 2
      t.references :loan, add_index: true

      t.timestamps null: false
    end
  end
end
