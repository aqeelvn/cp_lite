require "rails_helper"

RSpec.describe "Search", :type => :request do
  before(:each) do
    user = create(:user, :with_token)
    recipe1 = create(:recipe, user: user, title: "Egg omelette")
    recipe2 = create(:recipe, user: user, title: "Eggplant curry")
    recipe3 = create(:recipe, user: user, title: "Biryani")

    RecipeIndexer.new(recipe1).run(delay: false)
    RecipeIndexer.new(recipe2).run(delay: false)
    RecipeIndexer.new(recipe3).run(delay: false)
  end

  it "searches for egg and finds two results" do
    api_get "/search", params: { search: { query: "egg" } }

    expect(response).to have_http_status(:ok)
    expect(response.body).to match_json({ count: 2, page: 1 })
  end

  it "searches for biryani and finds one result" do
    api_get "/search", params: { search: { query: "biryani" } }

    expect(response).to have_http_status(:ok)
    expect(response.body).to match_json({ count: 1, page: 1 })
  end
end
