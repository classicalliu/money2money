class AddNameToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :name, :string
    add_column :admins, :sex, :string
    add_column :admins, :phone_number, :string
    add_attachment :admins, :avatar
  end
end
