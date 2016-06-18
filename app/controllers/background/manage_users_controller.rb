module Background
  class ManageUsersController < Background::ApplicationController
    def index
      @users = User.paginate(page: params[:page], per_page: 10)
    end

    def show
      @user = User.find_by(id: params[:id])
      @city = ''
      unless @user.last_sign_in_ip.nil?
        ip_info = GeoIP.new('lib/GeoLiteCity.dat').city(@user.last_sign_in_ip)
        unless ip_info.nil?
          city_hash = ip_info.to_hash
          @city = city_hash[:city_name]
        end
      end
      puts "@user.name = #{@user.name}"
    end

    # 简单搜索
    def search_user
      @search = User.search do
        fulltext params[:user][:search_text] do
          phrase_fields :name => 2.0
          phrase_fields :phone_number => 1.0
          query_phrase_slop 5
        end
        paginate :page => params[:page], :per_page => 10
      end

      # @results = User.where(id: search.results.map(&:id)).paginate(page: params[:page], per_page: 10)
      # @results = @search.results
    end

    # 高级搜索
    def search
      time_hash = {一周内: 1.week.ago, 两周内: 2.weeks.ago, 一个月内: 1.month.ago, 三个月内: 3.months.ago}

      @search = User.search do
        fulltext params[:user][:search_text] do
          phrase_fields :name => 3.0
          query_phrase_slop 100
        end

        unless params[:user][:search_time] == '不限'
          with(:created_at).greater_than(time_hash[:"#{params[:user][:search_time]}"])
        end

        unless params[:user][:search_sex] == '不限'
          with(:sex, params[:user][:search_sex])
        end

        paginate :page => params[:page], :per_page => 10
      end
    end
  end
end
