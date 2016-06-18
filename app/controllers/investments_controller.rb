class InvestmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # class << self
  #   attr_accessor :current_loan
  # end

  def new
    # @investment = Investment.new
    # @loan = Loan.find_by(id: params[:loan_id])
    # self.class.current_loan = @loan
  end

  # 投资人投资后创建投资信息
  def create
    # @loan = self.class.current_loan
    @loan = Loan.find_by(id: params[:investment][:loan_id])
    @investment = @loan.investments.build(investment_params)

    @investment.users << current_user
    # current_user.investments << @investment

    # 检查账户余额是否足够
    if @investment.mount > current_user.valid_capital
      @loan = Loan.find_by(id: params[:investment][:loan_id])
      flash.now[:error] = '余额不足'
      render 'loans/show'
    else
      # 如果充值成功, 累积投资的金额要加上去
      @user = current_user
      # @user.invest_count += params[:investment][:mount].to_f
      @user.frozen_capital += params[:investment][:mount].to_f
      if @investment.save && @user.save
        @loan.already_mount += @investment.mount
        @loan.update_attributes(already_mount: @loan.already_mount)
        current_user.valid_capital -= @investment.mount
        current_user.update_attributes(valid_capital: current_user.valid_capital)
        if @loan.reload.already_mount == @loan.reload.mount
          @loan.update_attributes(fulled: true)
          # 当累积投资满了的时候 投资者的待收金额要加上去
          @loan = @loan.reload
          @loan.investments.each do |investment|
            investment.users.each do |user|
              user.profit_not_yet += investment.mount * 1.1
              user.frozen_capital -= investment.mount
              user.save
            end
          end
        end
        flash[:success] = '提交成功'
        redirect_to root_url
      else
        render 'loans/show'
      end
    end


  end

  def index
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private

  def investment_params
    params.require(:investment).permit(:mount, :loan_id)
  end
end
