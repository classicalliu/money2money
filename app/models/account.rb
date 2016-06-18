class Account < ActiveRecord::Base
  belongs_to :user

  attr_accessor :search_time, :search_text

  # 搜索引擎
  searchable do
    text :mount

    text :user_name do
      user.name
    end

    text :user_email do
      user.email
    end

    time :created_at
  end
end
