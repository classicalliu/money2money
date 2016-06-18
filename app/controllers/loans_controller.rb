class LoansController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  # 显示所有的借款信息
  def index
    @loans = Loan.where("passed = 'yes' and mount != already_mount").order(updated_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  # 显示满标项目
  def full_index
    @loans = Loan.where('already_mount = mount').order(updated_at: :desc).paginate(page: params[:page], per_page: 10)
    render 'index'
  end

  # 显示单个借款的详细信息
  def show
    @loan = Loan.find_by(id: params[:id])
    @investment = Investment.new
  end

  def new
    @loan = Loan.new
    3.times {@loan.guarantors.build}
  end

  # 生成借款信息和三个担保人的信息
  def create
    @loan = current_user.loans.build(loan_params)
    # 设置应当归还的金额
    if @loan.mount.nil?
      flash[:warning] = '请填写信息'
      return redirect_to new_loan_url
    else
      @loan.should_return = @loan.mount * 1.1
    end

    @loan.guarantors.each do |guarantor|
      if guarantor.relationship == '父亲'
        guarantor.sex = '男'
      elsif guarantor.relationship == '母亲'
        guarantor.sex = '女'
      end
    end

    if @loan.save
      flash[:success] = '提交成功'
      redirect_to root_url
    else
      flash[:danger] = '提交失败'
      redirect_to new_loan_url
    end
  end


  def update
  end

  def show_user
    @loan = Loan.find_by(id: params[:id])
    @user = @loan.user
  end

  # 搜索
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

  private

  def loan_params
    params.require(:loan).permit(:mount, :use, :period, :way, {guarantors_attributes: [:name, :id_card, :phone_number, :sex, :address, :job, :salary, :relationship]})
  end
end
