class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  store_accessor :return_money, :mount, :date

  # has_many :active_relationships, class_name: 'Loan', foreign_key: 'follower_id'
  # has_many :passive_relationships, class_name: 'Loan', foreign_key: 'followed_id'
  # has_many :followers, through: :passive_relationships, source: :follower
  # has_many :following, through: :active_relationships, source: :followed

  # 充值用的虚拟属性
  attr_accessor :money

  # 搜索使用的虚拟属性
  attr_accessor :search_text
  attr_accessor :search_sex
  attr_accessor :search_time
  # validates :search_sex, inclusion: {in: %w(不限 男 女)}
  # validates :search_time, inclusion: {in: %w(不限 一周内 两周内 一个月内 三个月内)}

  # 用户头像
  has_attached_file :avatar, styles: {medium: '150x150>', thumb: '100x100>'}, default_url: ':style/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :loans
  has_many :accounts

  has_and_belongs_to_many :investments

  validates :name, presence: true
  VALID_PHONE_NUMBER_REGEX = /1[3|5|7|8|][0-9]{9}/
  validates :phone_number, presence: true, length: {is: 11}, format: {with: VALID_PHONE_NUMBER_REGEX}
  # TODO sex应该只接受男, 女
  validates :sex, presence: true, inclusion: {in: %w(男 女)}
  # TODO 应该接受id_card的验证
  # validates :id_card, presence: true

  validates :reg_agree, acceptance: true

  # 返回制定字符串的哈希摘要
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 搜索引擎
  searchable do
    text :name, :stored => true
    text :email, :id_card, :address
    text :phone_number
    string :sex
    time :created_at
    time :updated_at
    integer :id
  end
end
