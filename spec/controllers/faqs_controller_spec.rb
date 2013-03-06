require  'spec_helper'

describe FaqsController do
  render_views

  it "index action should render index template" do
    http_login
    get :index
    expect(response).to render_template(:index)
  end
end
