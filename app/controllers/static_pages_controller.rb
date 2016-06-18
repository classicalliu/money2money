class StaticPagesController < ApplicationController
  # 主页
  def home
  end

  # 关于
  def about
    @contact = Contact.new
  end

  # 联系我们
  def contact
  end

  # 帮助
  def help
  end
end
