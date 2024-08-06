class SearchController < ApplicationController
  def index
    # @query = Employee.ransack(params[:q])
    # @employees = @query.result(distinct: true)
    # @results = Employee.search(params[:search])
    @query = Employee.ransack(params[:q])
    @employees = @query.result(distinct: true)
  end
end
