class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show ]

  def index
    @tbd_dpt = Department.where(name: 'TBD')
    @departments = Departement.all.order('name ASC').excluding(@tbd_dpt)
    Team.new
  end

  def show
  end

  private
  
  def set_department
    @department = Department.find(params[:id])
  end
end
