class Investment < ActiveRecord::Base
  belongs_to :loan

  has_and_belongs_to_many :users

  validates :mount, presence: true, numericality: {only_integer: true, greater_than: 0, message: '金额必须大于0'}
  validate :validate_mount

  attr_accessor :search_text, :search_mount

  def validate_mount
    loan = Loan.find_by(id: self.loan_id)
    # 总共得到的投资的金额
    total_mount = 0
    # 计算总共得到了多少投资
    loan.investments.each do |investment|
      total_mount += investment.mount
    end
    left_money = loan.mount - total_mount
    if self.mount > left_money
      errors.add(:mount, '金额太大')
    end
  end

  # 搜索引擎
  searchable do
    text :user_name do
      users.first.name
    end

    text :loan_user_name do
      loan.user.name
    end

    string :mount
  end

end
