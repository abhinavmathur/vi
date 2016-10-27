require 'mina/multistage'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/scp'
require 'highline/import'


set :forward_agent, true
set :shared_dirs, fetch(:shared_dirs, []).push('tmp/pids', 'tmp/sockets')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml', 'config/application.yml', 'log', 'tmp')

set :app_path, lambda { "#{fetch(:deploy_to)}/#{fetch(:current_path)}" }

# Path of shared directory – where all files shared between deployments are
set :app_shared_path, lambda { "#{fetch(:deploy_to)}/#{fetch(:shared_path)}" }

task :environment do
  invoke :'rbenv:load'
end


task setup: :environment do
  command %[mkdir -p "#{fetch(:app_shared_path)}/tmp/sockets"]
  command %[chmod g+rx,u+rwx "#{fetch(:app_shared_path)}/tmp/sockets"]
  command %[mkdir -p "#{fetch(:app_shared_path)}/tmp/pids"]
  command %[chmod g+rx,u+rwx "#{fetch(:app_shared_path)}/tmp/pids"]
  command %[mkdir -p "#{fetch(:app_shared_path)}/tmp/log"]
  command %[chmod g+rx,u+rwx "#{fetch(:app_shared_path)}/tmp/log"]
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  invoke :'git:clone'
  invoke :'deploy:link_shared_paths'
  invoke :'bundle:install'
  invoke :'rails:db_migrate'
  invoke :'rails:assets_precompile'
  invoke :'deploy:cleanup'
  invoke :'secrets:upload'

  to :launch do
    invoke :'puma:restart'
    invoke :'sidekiq:start'
  end
end

