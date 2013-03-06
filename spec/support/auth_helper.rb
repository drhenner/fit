module AuthHelper
  def http_login
    user = 'ror-e'
    pw = 'ufcfit'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end
