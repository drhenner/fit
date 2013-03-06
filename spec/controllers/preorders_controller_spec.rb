require  'spec_helper'

describe PreordersController do
  # fixtures :all
  render_views

  before do
    http_login
  end

  it "index action should render index template" do
    Settings.stubs(:allow_preorders).returns(true)
    get :index
    expect(response).to render_template(:index)
  end

  it "index action should render index template" do
    Settings.stubs(:allow_preorders).returns(false)
    get :index
    expect(response).to redirect_to(root_url)
  end
#  it "show action should render show template" do
#    preorder = FactoryGirl.create(:product)
#    get :show, :id => preorder.id
#    expect(response).to render_template(:show)
#  end
end
