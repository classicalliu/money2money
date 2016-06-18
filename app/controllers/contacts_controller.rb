class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = '反馈已提交'
    else
      flash[:error] = '反馈信息填写有误'
    end
    redirect_to about_url
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :title, :message)
  end
end
