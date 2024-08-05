class EmployeesController < ApplicationController
  # before_action :authenticate_user!, only: [:show]
  before_action :set_employee, only: %i[ show edit update destroy ]

  require "mini_magick"

  def index
    @employees = Employee.all.order('last_name ASC')
    # @q = Employee.ransack(params[:q])
    # @employees = @q.result(distinct: true).order('last_name ASC')
  end

  def show
    @payslip = Payslip.where(employe_id: @employee)
  end

  def new
    @employee = Employee.new
    @employee.build_user
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      if @employee.save
        format.turbo_stream
        format.html { redirect_to employee_path(@employee), notice: "Employee was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to employee_path(@employee), notice: "Employee was successfully updated."
    else
      render :edit, status: :unprocessable_entity
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
      params.require(:employee).permit(:first_name, :last_name, :email, :city, :country, :manager, :team_id, :position_id, user_attributes: [:email, :password, :password_confirmation])
    end
end
