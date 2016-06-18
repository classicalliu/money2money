class Loan < ActiveRecord::Base
  # belongs_to :loan_model, polymorphic: true
  # 建立借款人与放贷人的关系
  # belongs_to :follower, class_name: 'User'
  # belongs_to :followed, class_name:  'User'

  # 建立借款人和担保人之间的关系,多对多
  # has_many :relations
  # has_many :guarantors, through: :relations

  # 搜索用的虚拟属性
  attr_accessor :search_text, :search_mount, :search_time, :search_use, :search_period
  # validates :search_mount, inclusion: {in: %w(不限 1000以下 1000到3000 3000到8000 8000以上)}
  # validates :search_time, inclusion: {in: %w(不限 一周内 两周内 一个月内 三个月内 三个月以上)}
  # validates :search_use, nclusion: {in: %w(不限 学费 车贷 数码贷款 其他)}
  # validates :search_period, inclusion: {in: %w(不限 3个月内 3到6个月 6到12个月 1年以上)}

  belongs_to :user
  has_many :guarantors
  accepts_nested_attributes_for :guarantors, allow_destroy: true

  has_many :investments


  # validates :follower_id, presence: true
  # validates :followed_id, presence: true

  validates :mount, presence: true, numericality: true
  validates :way, presence: true
  validates :use, presence: true
  validates :period, presence: true

  # 搜索引擎
  searchable do
    text :user_name do
      user.name
    end

    text :user_email do
      user.email
    end

    text :user_phone_number do
      user.phone_number
    end

    text :user_address do
      user.address
    end

    text :user_id_card do
      user.id_card
    end

    string :user_sex do
      user.sex
    end

    string :mount
    string :already_mount
    string :use
    integer :period
    string :way
    text :salary
    text :job
    text :message

    string :passed

    boolean :fulled

    time :created_at
  end
end
