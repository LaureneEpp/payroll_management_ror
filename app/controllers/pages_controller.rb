class PagesController < ApplicationController
    def dashboard
      @employees_count = Employee.count
      @tbd_dpt = Team.joins(:department).where(departments: {name: 'TBD'})
      @departments = Department.all.order('name ASC')
      @teams = Team.all.order('name ASC')
      @employees = Employee.all.order('last_name ASC').excluding(@tbd_employees)
      @managers = Employee.where(manager: true).order('last_name ASC')
      @employee = Employee.new
      @tbd_employees = Employee.joins(:position, :team).where("positions.name = 'TBD' OR teams.name = 'TBD'")
    end
end