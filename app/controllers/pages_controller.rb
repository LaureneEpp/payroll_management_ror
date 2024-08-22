class PagesController < ApplicationController
    def dashboard
      @employees_count = Employee.count
      @departments = Department.all.order('name ASC')
      @teams = Team.all.order('name ASC').excluding(@tbd_team)
      @employees = Employee.all.order('last_name ASC').excluding(@tbd_employees)
      @managers = Employee.joins(:team).where.not(teams: {user_id: nil}).order('employees.last_name ASC')
      @employee = Employee.new
      @tbd_employees = Employee.joins(:position, :team).where("positions.name = 'TBD' OR teams.name = 'TBD'")
      @tbd_team = Team.where(name: 'TBD')
    end
end