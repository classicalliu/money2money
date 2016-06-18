module Background
  class ManageLoansController < Background::ApplicationController
    # 查看前先验证管理员是否登录
    before_action :authenticate_admin!

    # 列出所有的待审核的项目的信息
    def index
      @loans = Loan.where("passed = 'no'").order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end

    # 列出待审核项目的详细信息
    # 项目详细信息, 申请人详细信息, 担保人详细信息
    # 带有同意或拒绝项目的功能
    def show
      @loan = Loan.find_by(id: params[:id])
      @investment = Investment.new
    end

    # 审核通过 => 更新数据库信息 + 审核通过的提示信息
    def update
      @loan = Loan.find_by(id: params[:loan][:loan_id])
      if @loan.update_attributes(passed: 'yes')
        @loan.investments do |investment|
          investment.user.profit_not_yet += investment.mount * 1.1
          investment.user.frozen_capital -= investment.mount
          investment.user.save
        end

        # 通知已经审核更新成功了
        flash.now[:success] = '审核通过'
      end
      # redrect_to background_manage_loan_url
      render 'show'
    end

    def reject_loan
      @loan = Loan.find_by(id: params[:loan][:loan_id])
      if @loan.update_attributes(passed: 'failed')
        @loan.investments do |investment|
          investment.user.fronzen_capital -= investment.mount
          investment.user.valid_capital += investment.mount
          investment.user.save
        end
        flash.now[:danger] = '审核不通过'
      end
      # redirect_to background_manage_loan_url
      render 'show'
    end

    def search_loan

    end

    def search
      time_hash = {一周内: 1.week.ago, 两周内: 2.weeks.ago, 一个月内: 1.month.ago, 三个月内: 3.months.ago}

      search_text = params[:loan][:search_text]
      search_mount = params[:loan][:search_mount]
      search_use = params[:loan][:search_use]
      search_period = params[:loan][:search_period]
      search_time = params[:loan][:search_time]

      @search = Loan.search do
        fulltext search_text do
          query_phrase_slop 100
        end

        if search_time == '三个月以上'
          with(:created_at).less_than 3.months.ago
        elsif search_time != '不限'
          with(:created_at).greater_than time_hash[:"#{search_time}"]
        end

        # (search_time == '三个月以上') ?
        #     with(:created_at).less_than 3.months.ago :
        #     with(:created_at).greater_than time_hash[:"#{search_time}"] if search_time != '不限'

        if search_mount == '1000以下'
          with(:mount).less_than(1000.0)
        elsif search_mount == '1000到3000'
          with(:mount, 1000...3000)
        elsif search_mount == '3000到8000'
          with(:mount, 3000...8000)
        elsif search_mount == '8000以上'
          with(:mount).greater_than(8000.0)
        end

        (search_use == '其他') ? without(:use, %w(学费 车贷 数码贷款)) : with(:use, "#{search_use}") if search_use != '不限'

        case search_period
          when '3个月内'
            with(:period, 0...3)
          when '3到6个月'
            with(:period, 3...6)
          when '6到12个月'
            with(:period, 6..12)
          when '1年以上'
            with(:period).greater_than(12)
          else
            # type code here
        end

        with(:passed, 'no')

        paginate page: params[:page], per_page: 10
      end
    end

    # 列出所有的满标项目
    def index_full
      @loans = Loan.where('mount = already_mount').order(updated_at: :desc).paginate(page: params[:page], per_page: 10)
    end

    # 查看满标项目的信息
    # 主要是项目的详细信息, 申请人详细信息, 担保人详细信息, 投资人详细信息
    # 显示项目的投资记录和还款情况
    def show_full
    end

    # 高级搜索
    def search_full
      time_hash = {一周内: 1.week.ago, 两周内: 2.weeks.ago, 一个月内: 1.month.ago, 三个月内: 3.months.ago}

      search_text = params[:loan][:search_text]
      search_mount = params[:loan][:search_mount]
      search_use = params[:loan][:search_use]
      search_period = params[:loan][:search_period]
      search_time = params[:loan][:search_time]

      @search = Loan.search do
        fulltext search_text do
          query_phrase_slop 100
        end

        if search_time == '三个月以上'
          with(:created_at).less_than 3.months.ago
        elsif search_time != '不限'
          with(:created_at).greater_than time_hash[:"#{search_time}"]
        end

        # (search_time == '三个月以上') ?
        #     with(:created_at).less_than 3.months.ago :
        #     with(:created_at).greater_than time_hash[:"#{search_time}"] if search_time != '不限'

        if search_mount == '1000以下'
          with(:mount).less_than(1000.0)
        elsif search_mount == '1000到3000'
          with(:mount, 1000...3000)
        elsif search_mount == '3000到8000'
          with(:mount, 3000...8000)
        elsif search_mount == '8000以上'
          with(:mount).greater_than(8000.0)
        end

        (search_use == '其他') ? without(:use, %w(学费 车贷 数码贷款)) : with(:use, "#{search_use}") if search_use != '不限'

        case search_period
          when '3个月内'
            with(:period, 0...3)
          when '3到6个月'
            with(:period, 3...6)
          when '6到12个月'
            with(:period, 6..12)
          when '1年以上'
            with(:period).greater_than(12)
          else
            # type code here
        end

        with(:passed, 'yes')
        with(:fulled, true)
        # with(:already_mount, :mount)


        paginate page: params[:page], per_page: 10
      end
    end

    # private
    #
    # def search_help(passed)
    #   time_hash = {一周内: 1.week.ago, 两周内: 2.weeks.ago, 一个月内: 1.month.ago, 三个月内: 3.months.ago}
    #
    #   search_text = params[:loan][:search_text]
    #   search_mount = params[:loan][:search_mount]
    #   search_use = params[:loan][:search_use]
    #   search_period = params[:loan][:search_period]
    #   search_time = params[:loan][:search_time]
    #
    #   @search = Loan.search do
    #     fulltext search_text do
    #       query_phrase_slop 100
    #     end
    #
    #     if search_time == '三个月以上'
    #       with(:created_at).less_than 3.months.ago
    #     elsif search_time != '不限'
    #       with(:created_at).greater_than time_hash[:"#{search_time}"]
    #     end
    #
    #     # (search_time == '三个月以上') ?
    #     #     with(:created_at).less_than 3.months.ago :
    #     #     with(:created_at).greater_than time_hash[:"#{search_time}"] if search_time != '不限'
    #
    #     if search_mount == '1000以下'
    #       with(:mount).less_than(1000.0)
    #     elsif search_mount == '1000到3000'
    #       with(:mount, 1000...3000)
    #     elsif search_mount == '3000到8000'
    #       with(:mount, 3000...8000)
    #     elsif search_mount == '8000以上'
    #       with(:mount).greater_than(8000.0)
    #     end
    #
    #     (search_use == '其他') ? without(:use, %w(学费 车贷 数码贷款)) : with(:use, "#{search_use}") if search_use != '不限'
    #
    #     case search_period
    #       when '3个月内'
    #         with(:period, 0...3)
    #       when '3到6个月'
    #         with(:period, 3...6)
    #       when '6到12个月'
    #         with(:period, 6..12)
    #       when '1年以上'
    #         with(:period).greater_than(12)
    #       else
    #         # type code here
    #     end
    #
    #     with(:passed, passed)
    #
    #     paginate page: params[:page], per_page: 10
    #   end
    # end
  end
end
