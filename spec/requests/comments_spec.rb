require "rails_helper"

RSpec.describe "Comment", :type => :request do
  it "creates a comment" do
    user = create(:user, :with_token)
    recipe = create(:recipe, user: create(:user))

    api_post "/recipes/#{recipe.id}/comments", params: { "comment": { "text":"commented" } }, user: user
    comment = recipe.comments.where(user: user).last

    expect(response).to have_http_status(:created)
    expect(comment).not_to eq(nil)
    expect(comment.text).to eq("commented")
  end

  it "should check if user is logged in" do
    recipe = create(:recipe, user: create(:user))
    api_post "/recipes/#{recipe.id}/comments", params: { "comment": { "text":"commented" } }

    expect(response).to have_http_status(:unauthorized)
  end

  it "deletes a comment" do
    user = create(:user, :with_token)
    recipe = create(:recipe, user: create(:user))
    comment = create(:comment, user: user, recipe: recipe)
    api_delete "/comments/#{comment.id}", user: user

    expect(response).to have_http_status(:ok)
  end
end
