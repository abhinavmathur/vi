class Ahoy::Store < Ahoy::Stores::ActiveRecordTokenStore
  # customize here
end

Ahoy.geocode = :async
Ahoy.job_queue = :low_priority