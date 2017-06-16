require "rails_helper"

RSpec.describe "Recipe", :type => :request do
  it "lists recipes" do
    user = create(:user, :with_token)
    create_list(:recipe, 20, user: user)

    api_get "/recipes"

    expect(response).to have_http_status(:ok)
    expect(response.body).to match_json({"count":20, page: 1})
  end

  it "create recipe" do
    user = create(:user, :with_token)

    recipe_params = {
      title: "My Recipe",
      steps_attributes: [{
        description: "Make Chicken"
      }],
      ingredients_attributes:[{
        name: "Chicken"
      }]
    }
    api_post "/recipes", params: { recipe: recipe_params }, user: user

    expect(response).to have_http_status(:created)
  end

  it "does not create recipe without user" do
    api_post "/recipes"

    expect(response).to have_http_status(:unauthorized)
  end

  it "does not create recipe without title" do
    user = create(:user, :with_token)
    recipe_params = {
      steps_attributes: [{
        description: "Make Chicken"
      }],
      ingredients_attributes:[{
        name: "Chicken"
      }]
    }
    api_post "/recipes", params: { recipe: recipe_params }, user: user

    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "does not create recipe without steps" do
    user = create(:user, :with_token)
    recipe_params = {
      title: "My Recipe",
      ingredients_attributes:[{
        name: "Chicken"
      }]
    }
    api_post "/recipes", params: { recipe: recipe_params }, user: user

    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "does not create recipe without ingredients" do
    user = create(:user, :with_token)
    recipe_params = {
      title: "My Recipe",
      steps_attributes:[{
        name: "Chicken"
      }]
    }
    api_post "/recipes", params: { recipe: recipe_params }, user: user

    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "updates a recipe" do
    author = create(:user, :with_token)
    recipe = create(:recipe, user: author, title: "First Title")

    recipe_params = {
      title: "Second Title"
    }
    api_patch "/recipes/#{recipe.id}", params: { recipe: recipe_params }, user: author
    updated_recipe = Recipe.find(recipe.id)

    expect(response).to have_http_status(:no_content)
    expect(updated_recipe.title).to eq("Second Title")
  end

  it "cannot override validation through update" do
    author = create(:user, :with_token)
    recipe = create(:recipe, user: author)
    recipe_params = {
      title: nil
    }
    api_patch "/recipes/#{recipe.id}", params: { recipe: recipe_params }, user: author
    expect(response).to have_http_status(:bad_request)
  end

  it "can delete a recipe by author" do
    author = create(:user, :with_token)
    recipe = create(:recipe, user: author)

    api_delete "/recipes/#{recipe.id}", user: author
    expect(response).to have_http_status(:ok)
  end

  it "can does not allow delete by non-author" do
    recipe = create(:recipe, user: create(:user, :with_token))
    another_user = create(:user, :with_token)

    api_delete "/recipes/#{recipe.id}", user: another_user
    expect(response).to have_http_status(:unauthorized)
  end
end
