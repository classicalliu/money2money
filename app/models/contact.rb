class Contact < ActiveRecord::Base
  validates :email, presence: true
  validates :name, presence: true
  validates :title, presence: true
end
