require 'spec_helper'

describe UserOauthController do
  describe "#create" do
    context "when omni auth hash is missing" do
      it "displays a message with login failure and redirects to login page" do
        stub_redirect_to_welcome
        post :create
        response.should redirect_to login_url
      end
    end

    context "displays a message with login failure and redirects to login page" do
      it "should display a message woth login successful and redirect to root url" do
        stub_env_for_omniauth(nil)
        post :create
        response.should redirect_to login_url
      end
    end
  end
end


def stub_env_for_omniauth(provider = "ufc", uid = "1234567", email = "john@doe.com", first_name = "John", last_name = "Doe")
  env = { "omniauth.auth" => { "provider" => provider, "uid" => uid, "info" => { "email" => email, "first_name" => first_name, "last_name" => last_name } } }
  controller.stubs(:env).returns(env)
  env
end
