require  'spec_helper'

describe Admin::Reports::OverviewsController do
  # fixtures :all
  render_views

  it "show action should render show template" do
    get :show
    expect(response).to render_template(:show)
  end
end
