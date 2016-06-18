class CreateInvestmentsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :investments_users, id: false do |t|
      t.integer :user_id
      t.integer :investment_id
    end
  end
end
