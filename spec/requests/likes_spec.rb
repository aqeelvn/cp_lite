require "rails_helper"

RSpec.describe "Like", :type => :request do
  it "creates a like" do
    user = create(:user, :with_token)
    recipe = create(:recipe, user: create(:user))

    api_post "/recipes/#{recipe.id}/like", user: user
    like = recipe.likes.find_by(user: user)

    expect(response).to have_http_status(:created)
    expect(like).not_to eq(nil)
  end

  it "should check if user is logged in" do
    recipe = create(:recipe, user: create(:user))
    api_post "/recipes/#{recipe.id}/like"

    expect(response).to have_http_status(:unauthorized)
  end

  it "unlikes a recipe" do
    user = create(:user, :with_token)
    recipe = create(:recipe, user: create(:user))
    create(:like, recipe: recipe, user: user)

    api_post "/recipes/#{recipe.id}/unlike", user: user

    expect(response).to have_http_status(:ok)
  end
end
