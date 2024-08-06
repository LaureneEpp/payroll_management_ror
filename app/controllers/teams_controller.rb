class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show ]
  before_action :set_department, only: %i[ show ]

  def index
    @tbd_team = Team.where(name: 'TBD')
    @teams = Team.all.order('name ASC').excluding(@tbd_team)
  end

  def show
    @team_manager = Employee.find_by(team_id: @team, manager: true)
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.turbo_stream
        format.html { redirect_to departments_path, notice: "Team was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def set_department
    @department = Department.find(params[:department_id])
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :description, :department_id)
  end
end
