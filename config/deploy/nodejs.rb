###
### NODEJS
################################################################################

namespace :provision do
  desc "Install nodejs for a javascript runtime"
  task :nodejs do
    queue "sudo apt-get -y install nodejs"
    queue "sudo apt-get clean -y"
  end
end