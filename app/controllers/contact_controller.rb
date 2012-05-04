class ContactController < ApplicationController
  def contact
    if params[:message] && !params[:message][:from].blank?
      ContactUsMailer.contact(params[:message]).deliver
      redirect_to root_path, notice: "Thank you for contacting us, we'll be in touch at our earliest convenience."
    else
      render :index, alert: "We need your email address so we can get back to you."
    end
  end
end
