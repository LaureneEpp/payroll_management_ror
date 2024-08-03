# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource({})
    resource.build_employee
    respond_with resource
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    # resource.build_employee unless resource.employee
    # respond_with resource
    super
  end

  # PUT /resource
  def update
    resource_updated = update_resource(resource, account_update_params)
    
    respond_to do |format|
      if resource_updated
        bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
        format.turbo_stream
        format.html { redirect_to after_update_path_for(resource) }
      else
        format.html { render :edit }
        format.turbo_stream
      end
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, employee_attributes: [:first_name, :last_name, :city, :country, :manager, :team_id, :position_id]])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, employee_attributes: [:first_name, :last_name, :city, :country, :manager, :team_id, :position_id]])
  end

  def after_sign_up_path_for(resource)
    super(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
  
  def update_resource(resource, params)
    resource.update(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
    # root_path
  end


  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, employee_attributes: [:first_name, :last_name, :city, :country, :manager, :team_id, :position_id])
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, employee_attributes: [:id, :first_name, :last_name, :city, :country, :manager, :team_id, :position_id, :_destroy])
  end
end

