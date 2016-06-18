module Background
  class HomesController < Background::ApplicationController
    # 后台管理页面的主页
    def home
      # 绘制图表数据
      # 月份
      @month_data = []
      @users = []
      @loans = []
      @investments = []

      6.times do |index|
        @month_data[index] = get_month_ago(index)
        @users[index] = User.where('created_at > ? and created_at < ?', Time.parse("#{@month_data[index].year}-#{@month_data[index].month}-1"), Time.parse("#{@month_data[index].year}-#{@month_data[index].next_month.month}-1"))
        @loans[index] = Loan.where('created_at > ? and created_at < ?', Time.parse("#{@month_data[index].year}-#{@month_data[index].month}-1"), Time.parse("#{@month_data[index].year}-#{@month_data[index].next_month.month}-1"))
        @investments[index] = Investment.where('created_at > ? and created_at < ?', Time.parse("#{@month_data[index].year}-#{@month_data[index].month}-1"), Time.parse("#{@month_data[index].year}-#{@month_data[index].next_month.month}-1"))
      end

      @types = {}
      @types[:school] = Loan.where("use = '学费'").count
      @types[:car] = Loan.where("use = '车贷'").count
      @types[:elec] = Loan.where("use = '数码贷款'").count
      @types[:others] = Loan.count - @types[:school] - @types[:car] - @types[:elec]

      @month_data.reverse!
      @users.reverse!
      @loans.reverse!

      @data = {}
      # @data[:mount] = []
      # @loans.each do |loan|
      #   total = 0
      #   loan.each do |n|
      #     total += n.mount
      #   end
      #   @data[:mount] << total
      # end
      # @data[:loan_mount] = @loans.map { |n| eval(n.map {|a| a.mount}.join('+'))}.map! {|n| n.nil? ? 0 : n}
      @data[:loan_mount] = @loans.map { |n| n.map {|a| a.mount}.inject(:+)}.map! {|n| n.nil? ? 0 : n}
      # @data[:mount].map! {|n| n = n.nil? ? 0 : n}
      # puts "data[:mount] = #{@data[:mount]}"
      @data[:month] = @month_data.map { |n| "#{n.month}月" }
      @data[:users] = @users.map { |n| n.size }
      @data[:loans] = @loans.map { |n| n.size }
      @data[:investments] = @investments.map {|n| n.size}
      @data[:investment_mount] = @investments.map {|n| n.map { |a| a.mount}.inject(:+)}.map! {|n| n.nil? ? 0 : n}

      @data[:types] = @types
    end


    private

    def get_month_ago(mount)
      time = Time.now
      mount.times do
        time = time.last_month
      end
      time
      # (Time.now.month - 1 - mount) % 12 + 1
    end
  end
end