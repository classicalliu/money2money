module Background
  class ManageContactsController < Background::ApplicationController
    def index
      @contacts = Contact.order(created_at: :asc).paginate(page: params[:page], per_page: 20)
    end
  end
end
