###
### SETUP
################################################################################

task setup: :environment do
  queue %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue %[mkdir -p "#{deploy_to}/#{shared_path}/tmp"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp"]

  queue %[mkdir -p "#{deploy_to}/#{shared_path}/run"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/run"]

  queue %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids"]

  queue %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/sockets"]

  queue %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
end