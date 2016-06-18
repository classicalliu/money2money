class UsersController < ApplicationController
  before_action :authenticate_user!

  # 账户资金信息
  def account_info
    @user = current_user
    @investmens = @user.investments
    @investmens.each do |investment|
      @user.invest_count += investment.mount
    end
  end

  def add_money
    @user = User.new
  end

  def return_loan
    @user = User.new
    @loan = Loan.find_by(id: params[:id])
  end

  def return_pay
    @user = current_user
    @loan = Loan.find_by(id: params[:user][:id_loan])
    money = params[:user][:money].to_f

    if @user.valid_capital < money
      flash.now[:warning] = '余额不足'
      render 'return_loan'
    else
      @user.valid_capital -= money
      @loan.already_pay += money
      @loan.return_money ||= []
      @loan.return_money << {mount: money, date: Time.now}

      if @user.save && @loan.save
        # 需要在投资者那里加上累积收益
        @loan.investments.each do |investment|
          investment.users.each do |user|
            user.profit_count += money * (investment.mount / @loan.mount)
            user.save
          end
        end

        flash.now[:success] = '还款成功'
      end
      render 'account_info'
    end
  end

  # 充值
  def pay
    @user = current_user
    money = @user.valid_capital + params[:user][:money].to_f
    @account = @user.accounts.build
    @account.mount = params[:user][:money].to_f
    if @user.update_attributes(valid_capital: money) && @account.save
      flash.now[:success] = '充值成功'
    end
    render 'account_info'
  end

  # 用户资料
  def show
    @user = current_user
    @city = ''
    unless @user.last_sign_in_ip.nil?
      ip_info = GeoIP.new('lib/GeoLiteCity.dat').city(@user.last_sign_in_ip)
      unless ip_info.nil?
        city_hash = ip_info.to_hash
        @city = city_hash[:city_name]
      end
    end
  end

  # 更新用户头像
  def update_head
    update_with_password
  end

  # 更新用户信息
  def update
    update_with_password
  end


  #更新用户头像的辅助方法

  def upload_image
    @user = current_user

    if @user.update_attributes(avatar_params)
      redirect_to @user, notice: '更新成功!'
    else
      redirect_to root_url
    end
  end

  # 更新用户不包含密码的信息
  def edit
    @user = current_user
  end

  # 更新用户的个人资料
  def update_info
    @user = current_user

    if @user.update_attributes(user_params)
      redirect_to @user, notice: '更新成功!'
    else
      redirect_to root_url
    end
  end

  private

  def update_with_password
    if !params[:current_password].blank? or !params[:password].blank? or !params[:password_confirmation].blank?
      super
    else
      params.delete(:current_password)
      if params[:user][:is_head] == 'true'
        self.upload_image
      else
        self.update_info
      end
    end
  end

  def avatar_params
    params.require(:user).permit(:avatar)
  end

  def user_params
    params.require(:user).permit(:email, :name, :phone_number, :address, :id_card, :sex)
  end
end
