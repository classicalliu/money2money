module Background
  class ManageInvestmentsController < Background::ApplicationController
    def index
      @investments = Investment.all.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end

    def search
      @search = Investment.search do
        search_mount = params[:investment][:search_mount]
        search_text = params[:investment][:search_text]

        fulltext search_text do
          query_phrase_slop 100
        end

        if search_mount == '1000以下'
          with(:mount).less_than(1000.0)
        elsif search_mount == '1000到3000'
          with(:mount, 1000...3000)
        elsif search_mount == '3000到8000'
          with(:mount, 3000...8000)
        elsif search_mount == '8000以上'
          with(:mount).greater_than(8000.0)
        end
      end
    end
  end
end