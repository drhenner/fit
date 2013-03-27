if Rails.env == 'production'
  Airbrake.configure do |config|
    config.api_key = '75044c76463c0f5c11f163627e5ce0da'
  end
end
if Rails.env == 'staging'
  Airbrake.configure do |config|
    config.api_key = 'cd3b5bb93ab37f8eb3403d24031445d8'
  end
end
