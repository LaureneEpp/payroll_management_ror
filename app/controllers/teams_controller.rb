class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update ]
  before_action :set_department, only: %i[ show ]

  def index
    @tbd_team = Team.where(name: 'TBD')
    @teams = Team.all.order('name ASC').excluding(@tbd_team)
  end

  def show
    @team_manager = Employee.find_by(user_id: @team.user_id)
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to departments_path }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
    if @team.update(team_params)
        format.html { redirect_to department_team_path(@team.department, @team)}
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
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
    params.require(:team).permit(:name, :description, :department_id, :user_id)
  end
end
