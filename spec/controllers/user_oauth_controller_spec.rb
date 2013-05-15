require 'spec_helper'

describe UserOauthController do
  describe "#annonymous user" do
    context "when email doesn't exist in the system" do
      before(:each) do
        stub_omniauth_hash
        get 'ufc', provider: 'ufc'
        @user = User.where(:email => "john@doe.com").first
      end

      it { @user.should_not be_nil }

      it "should create user with uid" do
        user = User.where(:provider => "ufc", :uid => "1234567").first
        user.should_not be_nil
      end
      it { flash[:notice].should == I18n.t('login_successful')}

      it { response.should redirect_to root_url }
    end

    context "when email exists in the system" do
      before(:each) do
        stub_omniauth_hash
        User.create(:email => "john@doe.com", :first_name => "John", :last_name => "Doe", :country_id => 214 )

        get 'ufc', provider: 'ufc'
      end

      it { flash[:notice].should == I18n.t('login_successful')}

      it { response.should redirect_to root_url }
    end
  end

  describe "#ufc" do
    context "when omni auth hash is missing" do
      before(:each) do
        stub_redirect_to_welcome
        get 'ufc', provider: 'ufc'
      end

      it { flash[:notice].should == I18n.t('login_failure')}

      it { response.should redirect_to root_url }
    end
  end
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  env = { "omniauth.auth" => OmniAuth::AuthHash.new({
                              :provider => 'ufc',
                              :uid => '1234567',
                              :info => {
                                'first_name' => 'John',
                                'last_name' => 'Doe',
                                'email' => 'john@doe.com',
                                'country' => {
                                  'alpha3' => 'USA'
                                }
                              }
                            }) }
  request.stubs(:env).returns(env)
end
