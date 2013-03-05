require  'spec_helper'

describe Admin::Reports::OverviewsController do
  # fixtures :all
  render_views

  it "show action should render show template" do
    overview = FactoryGirl.create(:overview)
    get :show, :id => overview.id
    expect(response).to render_template(:show)
  end
end
