module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :phone_number, :address, :id_card, :sex, :avatar]
    devise_parameter_sanitizer.for(:account_update) << [:name, :phone_number, :address, :id_card, :sex, :avatar]
  end

end

DeviseController.send :include, DevisePermittedParameters
