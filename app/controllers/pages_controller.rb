class PagesController < ApplicationController
    def dashboard
      @employees_count = Employee.count
      @departments = Department.all.order('name ASC')
      @teams = Team.all.order('name ASC').excluding(@tbd_team)
      @employees = Employee.all.order('last_name ASC').excluding(@tbd_employees)
      manager_user_ids = Team.pluck(:user_id).uniq
      @managers_without_team = Employee.joins(:user).where(users: { role: User.roles[:manager] }).where.not(user_id: manager_user_ids).order('employees.last_name ASC')
      @managers =  Employee.joins(:team).where(teams: { user_id: Employee.select(:user_id) }).order('employees.last_name ASC')
      @employee = Employee.new
      @tbd_employees = Employee.joins(:position, :team).where("positions.name = 'TBD' OR teams.name = 'TBD'")
      @tbd_team = Team.where(name: 'TBD')
      @teams_without_manager = Team.where(user_id: nil).excluding(@tbd_team)
    end
end