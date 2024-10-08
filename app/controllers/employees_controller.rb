class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]

  require "mini_magick"

  def index
    @q = Employee.ransack(params[:q])
    @employees = @q.result(distinct: true).order('last_name ASC')
    @standard_employees = @employees.joins(:user).where(users:{role: 0})
    @managers = @employees.joins(:user).where(users:{role: 1})
  end

  def show
  end

  def new
    @employee = Employee.new
    @employee.build_user
  end

  def edit
    @employee.build_user unless @employee.user
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.user.present?
      @employee.user.email = @employee.email
      @employee.user.password = "password" unless @employee.user.password.present?
      @employee.user.password_confirmation = "password" unless @employee.user.password_confirmation.present?
    end
    respond_to do |format|
      if @employee.save
        format.turbo_stream
        format.html { redirect_to employee_path(@employee)}
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @employee.update(employee_params)
      respond_to do |format|
        if @employee.save
          format.turbo_stream
          format.html { redirect_to employee_path(@employee) }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :email, :city, :country, :team_id, :position_id, user_attributes: [:id, :email, :password, :password_confirmation, :role])
    end
end
