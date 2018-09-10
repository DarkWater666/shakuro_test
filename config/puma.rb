workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

# app_dir = File.expand_path('..', __dir__)
# shared_dir = "#{app_dir}/tmp"

preload_app!

rackup      DefaultRackup
port        ENV.fetch('port') { 3030 }
environment ENV.fetch('RAILS_ENV') { 'development' }

# daemonize
activate_control_app

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/
  # deploying-rack-applications-with-the-puma-web-server#on-worker-boot
  #  ActiveRecord::Base.establish_connection
end
