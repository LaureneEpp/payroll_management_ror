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

  # def create
  #   build_resource(sign_up_params)
  #   resource.build_employee
    
  #   resource.save
  
  #   respond_to do |format|
  #     if resource.persisted?
  #       if resource.active_for_authentication?
  #         sign_up(resource_name, resource)
  #         format.turbo_stream 
  #         format.html { redirect_to after_sign_up_path_for(resource) }
  #       else
  #         # set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
  #         expire_data_after_sign_in!
  #         format.turbo_stream
  #         format.html { redirect_to after_inactive_sign_up_path_for(resource) }
  #       end
  #     else
  #       # clean_up_passwords resource
  #       # set_minimum_password_length
  #       format.turbo_stream 
  #       format.html { render :new }
  #     end
  #   end
  # end
  

  # GET /resource/edit
  def edit
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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role, employee_attributes: [:id, :first_name, :last_name, :city, :country, :team_id, :position_id]])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :role, employee_attributes: [:id, :first_name, :last_name, :city, :country, :team_id, :position_id]])
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
    profile_path
  end


  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, employee_attributes: [:id, :first_name, :last_name, :city, :country, :team_id, :position_id])
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :role, employee_attributes: [:id, :first_name, :last_name, :city, :country, :team_id, :position_id, :_destroy])
  end
end

