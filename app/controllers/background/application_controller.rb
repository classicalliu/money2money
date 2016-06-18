module Background
  class ApplicationController < ::ApplicationController
    layout 'admin_lte_2'

    before_action :authenticate_admin!
  end
end
