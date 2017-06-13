require "rails_helper"

RSpec.describe "Recipe", :type => :request do
  it "lists recipes" do
    user = create(:user, :with_token)
    create_list(:recipe, 20, user: user)

    api_get "/recipes"

    expect(response).to have_http_status(:ok)
    expect(response.body).to match_json({"count":20, page: 1})
  end
end
