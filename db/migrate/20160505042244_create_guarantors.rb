class CreateGuarantors < ActiveRecord::Migration
  def change
    create_table :guarantors do |t|
      t.references :loan, index: true

      t.string :name
      t.string :id_card, unique: true
      t.string :sex
      t.string :phone_number
      t.string :address
      t.string :job
      t.decimal :salary, precision: 8, scale: 2
      t.string :relationship

      t.timestamps null: false
    end
  end
end
