require "rails_helper"

RSpec.describe "Bookmark", :type => :request do
  it "creates a bookmark" do
    user = create(:user, :with_token)
    recipe = create(:recipe, user: create(:user))

    api_post "/recipes/#{recipe.id}/bookmark", user: user
    bookmark = user.bookmarks.find_by(recipe: recipe)

    expect(response).to have_http_status(:created)
    expect(bookmark).not_to eq(nil)
  end

  it "should check if user is logged in to create" do
    recipe = create(:recipe, user: create(:user))
    api_post "/recipes/#{recipe.id}/bookmark"

    expect(response).to have_http_status(:unauthorized)
  end

  it "removes a bookmark" do
    user = create(:user, :with_token)
    recipe = create(:recipe, user: create(:user))
    create(:bookmark, recipe:recipe, user: user)

    api_post "/recipes/#{recipe.id}/remove_bookmark", user: user
    bookmark = user.bookmarks.find_by(recipe: recipe)

    expect(response).to have_http_status(:ok)
    expect(bookmark).to eq(nil)
  end
end
