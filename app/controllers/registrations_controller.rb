class RegistrationsController < Devise::RegistrationsController

  def new
    @plans = Plan.order(:monthly_cost)
    @plan = Plan.find(params[:plan_id]) rescue nil
    super
  end

end