class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      # t.integer :follower_id
      # t.integer :followed_id

      # t.belongs_to :user
      t.references :user, index: true
      # 借款金额
      t.decimal :mount, precision: 8, scale: 2, null: false
      # 用途
      t.string :use
      # 还款周期(月计)
      t.integer :period
      # 还款方式
      t.string :way


      t.timestamps null: false
    end
  end
end
