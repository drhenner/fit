require  'spec_helper'

describe UnsubscribesController do
  # fixtures :all
  render_views

  it "show action should render show template" do
    newsletter = FactoryGirl.create(:newsletter)
    unsubscribing_user = FactoryGirl.create(:user)
    expect(unsubscribing_user.newsletter_ids).to eq [newsletter.id]
    get :show, :email => unsubscribing_user.email, :key => UsersNewsletter.unsubscribe_key(unsubscribing_user.email)
    expect(response).to render_template(:show)
    unsubscribing_user.reload
    expect(unsubscribing_user.newsletter_ids).to eq []
  end
end
