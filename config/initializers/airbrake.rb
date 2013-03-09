if Rails.env == 'production'
  Airbrake.configure do |config|
    config.api_key = '75044c76463c0f5c11f163627e5ce0da'
  end
end
