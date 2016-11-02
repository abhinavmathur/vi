###
### NGINX
################################################################################

namespace :nginx do
  %w(stop start restart reload status).each do |action|
    desc "#{action.capitalize} NGINX"
    task action.to_sym => :environment do
      queue  %(echo "-----> #{action.capitalize} NGINX")
      queue "sudo service nginx #{action}"
    end
  end
end

