class PlansController < ApplicationController
  def index
    @plans = Plan.order(:monthly_cost)
  end
end
