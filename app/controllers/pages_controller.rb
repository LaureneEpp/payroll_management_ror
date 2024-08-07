class PagesController < ApplicationController
    def dashboard
      @employees_count = Employee.count
      @departments = Department.all.order('name ASC')
      @teams = Team.all.order('name ASC')
      @employees = Employee.all.order('last_name ASC').excluding(@tbd_employees)
      @managers = Employee.joins(:user).where(users: { role: 'manager' }).order('employees.last_name ASC')
      @employee = Employee.new
      @tbd_employees = Employee.joins(:position, :team).where("positions.name = 'TBD' OR teams.name = 'TBD'")
    end
end