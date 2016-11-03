require 'mina/multistage'
require 'mina_sidekiq/tasks'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/puma'
require 'mina/scp'



###
### SERVER
################################################################################


set :app_root,              '/home/raaaaj5000/RubymineProjects/vi'   # Local path to application
#set :template_path,         "#{app_root}/config/deploy/templates" # Local path to deploy templates
set :shared_paths,          ['config/database.yml',               # Database config
                             'config/application.yml',            # Figaro variables
                             'config/secrets.yml',                # Rails secrets
                             'public/uploads',                    # Image uploads
                             'log',                               # Log files
                             'tmp']

require_relative 'deploy/setup'
require_relative 'deploy/nodejs'
require_relative 'deploy/rbenv'
require_relative 'deploy/nginx'
require_relative 'deploy/secrets'
require_relative 'deploy/sidekiq'

### Load rbenv into the session
task :environment do
  invoke :'rbenv:load'
end

###
### MINA DEPLOY
################################################################################

desc "Deploys the current version to the server."
task deploy: :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end

  deploy do
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'secrets:upload'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'puma:restart'
      invoke :'sidekiq:start'
    end
  end
end
