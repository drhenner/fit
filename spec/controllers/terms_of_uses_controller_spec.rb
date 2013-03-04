require  'spec_helper'

describe TermsOfUsesController do
  # fixtures :all
  render_views

  it "show action should render show template" do
    get :show
    expect(response).to render_template(:show)
  end
end
