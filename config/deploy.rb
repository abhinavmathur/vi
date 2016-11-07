server '138.197.140.132', user: 'raj', roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:abhinavmathur/vi.git'
set :application,     'vi'
set :user,            'abhinavmathur'
set :puma_threads,    [4, 16]
set :puma_workers,    1

# Don't change these unless you know what you're doing
set :shared_path, -> do
  {
      production: '/var/www/vivieu.com/shared',
      staging: '/var/www/staging.vivieu.com/shared'
  }
end
set :pty,             true
set :use_sudo,        true
set :stage, -> { fetch(:deploy_stage)}
set :deploy_via,      :remote_cache
set :deploy_to, -> { fetch(:deploy_location) }
set :puma_bind, -> do
  {
      production: "unix://#{shared_path}/tmp/sockets/production-puma.sock",
      staging: "unix://#{shared_path}/tmp/sockets/staging-puma.sock"
  }
end
set :puma_state,      "#{fetch :shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{fetch :shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{fetch :shared_path}/log/puma.error.log"
set :puma_error_log,  "#{fetch :shared_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false  # Change to true if using ActiveRecord

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.3.1'

set :rbenv_path, '/home/raj/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml config/secrets.yml config/application.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

before 'deploy:migrate', 'secrets:upload_to_staging'

namespace :secrets do
  desc 'upload secrets'
  task :upload_to_staging do
    on roles(:app) do
      %w(application.yml secrets.yml database.yml).each do |f|
        upload!("/home/raaaaj5000/RubymineProjects/vi/config/#{f}", "/var/www/staging.vivieu.com/shared/config/#{f}")
      end
    end
  end
  task :upload_to_production do
    on roles(:app) do
      %w(application.yml secrets.yml database.yml).each do |f|
        upload!("/home/raaaaj5000/RubymineProjects/vi/config/#{f}", "/var/www/vivieu.com/shared/config/#{f}")
      end
    end
  end
end

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      puts 'Checking git sync...'
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma

