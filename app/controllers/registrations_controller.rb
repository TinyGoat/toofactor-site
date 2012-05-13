class RegistrationsController < Devise::RegistrationsController

  def new
    @plans = Plan.order(:monthly_cost)
    super
  end

end