class Guarantor < ActiveRecord::Base
  # 建立借款人与担保人之间的关系
  # has_many :relations
  # has_many :loans, through: :relations
  belongs_to :loan

  validates :name, presence: true
  VALID_PHONE_NUMBER_REGEX = /1[3|5|7|8|][0-9]{9}/
  validates :phone_number, presence: true, length: {is: 11}, format: {with: VALID_PHONE_NUMBER_REGEX}
  # validates_numericality_of :salary, greater_than_or_equal_to: 0.0
  # TODO salary 的精度需要控制
  validates :salary, format: { with: /\d+(?:\.\d{0,2})?/ }, numericality: {greater_than_or_equal_to: 0.0}
  validates :address, presence: true
  validates :id_card, presence: true
  validates :job, presence: true
  validates :sex, presence: true, inclusion: {in: %w(男 女), message: '您填写的性别信息有误!'}
end
