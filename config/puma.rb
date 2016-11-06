deploy_staging = '/var/www/staging.vivieu.com'
deploy_production = '/var/www/vivieu.com'

workers  1

threads 0, 16

rackup      DefaultRackup
environment ENV['RACK_ENV'] || 'production'
daemonize   true

if ENV['RACK_ENV'] == 'staging'
  bind "unix:#{deploy_staging}/shared/tmp/sockets/puma.sock"
  pidfile "#{deploy_staging}/shared/tmp/pids/puma.pid"
  state_path "#{deploy_staging}/shared/tmp/sockets/puma.state"

  stdout_redirect "#{deploy_staging}/shared/log/puma.stdout.log", "#{deploy_staging}/shared/log/puma.stderr.log", true
  activate_control_app "unix:#{deploy_staging}/shared/tmp/sockets/pumactl.sock", { no_token: true }
else
  bind "unix:#{deploy_production}/shared/tmp/sockets/puma.sock"
  pidfile "#{deploy_production}/shared/tmp/pids/puma.pid"
  state_path "#{deploy_production}/shared/tmp/sockets/puma.state"

  stdout_redirect "#{deploy_production}/shared/log/puma.stdout.log", "#{deploy_production}/shared/log/puma.stderr.log", true
  activate_control_app "unix:#{deploy_production}/shared/tmp/sockets/pumactl.sock", { no_token: true }
end

on_worker_boot do
  require 'active_record'
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection
end
