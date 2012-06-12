Toofactor::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => '0.0.0.0:8080' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  API_KEY_SALT = '7fc0c23356b36bfadd4706a151b3e56d3fcac1b0e2a7cd0b0c0c1f7c83baf4ff0c69bccc38f26df4733150be9f03adb82a8e5c5be4f1c15763d5de6b840ca1fa'
  DEV_API_KEY_SALT = '6c2e7304b34f9d61ddc5a7cfa773f51fc9d05770836a48c100678727a48aeaf5e30d78c3eae912cf230dd7ce9eac48aa86363e4e236cc38476336a0b2fd0b55c'
  $REDIS = Redis.new(:host => "127.0.0.1", :port => 6379)
end
