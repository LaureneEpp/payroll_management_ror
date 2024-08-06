class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_query
  
  def set_query
    @q = Employee.ransack(params[:q])
    @employees = @q.result(distinct: true)
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name address phone date_of_birth gender])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name address phone date_of_birth gender])
  end
end
