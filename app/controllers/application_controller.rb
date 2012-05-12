class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_http_auth_on_staging

  private
  def require_http_auth_on_staging
    if Rails.env.staging?
      authenticate_or_request_with_http_basic do |user_name, password|
        if ENV['HTTP_AUTH_USER_NAME'].blank? || ENV['HTTP_AUTH_PASSWORD'].blank?
          true
        else
          user_name == ENV['HTTP_AUTH_USER_NAME'] && password == ENV['HTTP_AUTH_PASSWORD']
        end
      end
    end
  end
end
