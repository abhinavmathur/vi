#todo change to vivieu.com in production
OmniAuth.config.full_host = Rails.env.production? ? 'http://localhost:3000' : 'http://localhost:3000'