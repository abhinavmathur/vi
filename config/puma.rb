workers 1

threads 0, 16

preload_app!

daemonize

rackup      DefaultRackup
environment ENV["RAILS_ENV"] || "production"

bind "unix:/var/www/vivieu.com/shared/tmp/sockets/puma.sock"
pidfile "/var/www/vivieu.com/shared/tmp/pids/puma.pid"
state_path "/var/www/vivieu.com/shared/tmp/sockets/puma.state"

stdout_redirect "/var/www/vivieu.com/shared/log/puma.stdout.log", "/var/www/vivieu.com/shared/log/puma.stderr.log", true
activate_control_app "unix:/var/www/vivieu.com/shared/tmp/sockets/pumactl.sock", { no_token: true }

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection
end