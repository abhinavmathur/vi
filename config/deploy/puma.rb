###
### PUMA
################################################################################

namespace :puma do
  desc "Update puma config."
  task :config do
    puma_config = erb("#{template_path}/puma.rb.erb")
    queue %[echo '#{puma_config}' > #{deploy_to}/#{shared_path}/config/puma.rb]
    invoke :'puma:restart'
  end
end