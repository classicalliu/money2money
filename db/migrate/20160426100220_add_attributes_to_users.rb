class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :phone_number, :string
    add_column :users, :id_card, :string
    add_column :users, :sex, :string
    add_column :users, :address, :string
  end
end
