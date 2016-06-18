class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if request.path != '/users/sign_in' &&
        request.path != '/users/sign_up' &&
        request.path != '/users/password/new' &&
        request.path != '/users/password/edit' &&
        request.path != '/users/confirmation' &&
        request.path != '/users/sign_out' &&
        request.path != '/admins/sign_in' &&
        request.path != '/admins/sign_up' &&
        request.path != '/admins/password/new' &&
        request.path != '/admins/password/edit' &&
        request.path != '/admins/confirmation' &&
        request.path != '/admins/sign_out' &&
        !request.xhr? # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    # if resource.name == :user
    #   path = root_path
    # else
    #   path = background_root_path
    # end
    session[:previous_url] || root_path
  end

  protected

  # deivse 的布局, 管理员界面使用admin_lte_2, 用户界面使用application
  def layout_by_resource
    if devise_controller? && resource_name == :admin
      'admin_lte_2'
    else
      'application'
    end
  end
end
