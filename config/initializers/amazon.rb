require 'amazon/ecs'

# default options:
#  options[:version] => "2013-08-01"
#  options[:service] => "AWSECommerceService"
Amazon::Ecs.configure do |options|
  options[:AWS_access_key_id] = ENV["ACCESS_KEY_ID"]
  options[:AWS_secret_key] = ENV["SECRET_ACCESS_KEY"]
  options[:associate_tag] = 'raaaaj5000-20'
end