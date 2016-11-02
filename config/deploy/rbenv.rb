###
### RBENV
################################################################################

set :ruby_version,         '2.2.2'

namespace :provision do
  desc "Install ruby #{ruby_version} with rbenv"
  task :rbenv do
    queue "curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash"
    invoke :'rbenv:load'
    queue "rbenv install #{ruby_version}"
    queue "rbenv global #{ruby_version}"
    queue "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
    queue "gem install bundler"
    queue "rbenv rehash"
  end
end