class SearchController < ApplicationController
  def index
    @query = Employee.ransack(params[:q])
    @employees = @query.result(distinct: true)
    @standard_employees = @employees.joins(:user).where(users:{role: 0})
    @managers = @employees.joins(:user).where(users:{role: 1})
  end
end
