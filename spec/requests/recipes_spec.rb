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
end
