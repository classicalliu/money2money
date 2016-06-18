module Background
  class ManageAccountsController < Background::ApplicationController
    def index
      @accounts = Account.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    end

    def search
      search_text = params[:account][:search_text]
      search_time = params[:account][:search_time]
      @search = Account.search do
        fulltext search_text do
          phrase_fields :user_name => 3.0
          query_phrase_slop 100
        end

        case search_time
          when '一周内'
            with(:created_at).greater_than 1.week.ago
          when '两周内'
            with(:created_at).greater_than 2.weeks.ago
          when '一个月内'
            with(:created_at).greater_than 1.month.ago
          when '三个月内'
            with(:created_at).greater_than 3.months.ago
          when '三个月以上'
            with(:created_at).less_than 3.months.ago
          else
            # 不限
            # type code here
        end
      end
    end
  end
end