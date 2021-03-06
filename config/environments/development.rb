Miletracker::Application.configure do
  config.eager_load = false
  config.cache_classes = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  
  config.assets.debug = true
  config.serve_static_assets = true
  config.assets.compress = true
  config.assets.compile = true
  
  Rails.logger = Logger.new(STDOUT)
end
