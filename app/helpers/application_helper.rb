module ApplicationHelper
  # 页面的title的辅助函数
  def full_title(page_title = '')
    base_title = 'Money2Money'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # 日期显示
  def get_date(time)
    "#{time.year}年 #{time.month}月 #{time.day}日"
  end

  # 时间显示
  def get_time(time)
    I18n.l time
  end
end
