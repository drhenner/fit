require  'spec_helper'

describe ShippingReturnsController do
  # fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    expect(response).to render_template(:index)
  end
end
