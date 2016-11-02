###
### SECRETS
################################################################################

namespace :secrets do
  desc "Upload secret configuration files"
  task :upload do
    scp_upload("#{app_root}/config/application.yml", "#{deploy_to}/#{shared_path}/config/", verbose: true)
    scp_upload("#{app_root}/config/database.yml", "#{deploy_to}/#{shared_path}/config/", verbose: true)
    scp_upload("#{app_root}/config/secrets.yml", "#{deploy_to}/#{shared_path}/config/", verbose: true)
  end
end