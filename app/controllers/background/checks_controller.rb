module Background
  class ChecksController < Background::ApplicationController
    def index
      @loans = Loan.all
    end
  end
end