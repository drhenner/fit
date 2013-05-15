require 'omniauth-ufc'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ufc, Settings.ufc.client_id, Settings.ufc.client_secret,
    :client_options => {
      site: Settings.ufc.oauth_site,
      ssl: { ca_file: Settings.ssl_cert_path }
    },
    :provider_ignores_state => true
end
