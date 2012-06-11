class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!

  def edit
    @subscription = current_user.subscription
  end

end