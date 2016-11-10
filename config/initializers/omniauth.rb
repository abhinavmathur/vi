#todo change to vivieu.com in production
if Rails.env.staging?
  OmniAuth.config.full_host = 'https://staging.vivieu.com'
elsif Rails.env.production?
  OmniAuth.config.full_host = 'https://www.vivieu.com'
else
  OmniAuth.config.full_host = 'http://localhost:3000'
end
