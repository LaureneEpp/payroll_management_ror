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
        @team.update_leader_roles(@team.user_id)
        format.html { redirect_to departments_path, notice: "Team was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Team was successfully created." }

      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    previous_leader_id = @team.user_id
    new_leader_id = team_params[:user_id]

    respond_to do |format|
      @team.update_leader_roles(new_leader_id, previous_leader_id)
      if @team.update(team_params)
        format.html { redirect_to department_team_path(@team, @team.department), notice: "Team was successfully updated." }
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
