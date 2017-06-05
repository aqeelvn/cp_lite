class RecipesController < ApplicationController
  before_action :require_login, except: %i(show)

  def edit
    @recipe = user_recipe
  end

  def destroy
    recipe = user_recipe
    recipe.destroy
    redirect_to root_path
  end

  def show
    @recipe = recipe
  end

  def new
    @recipe = Recipe.new
  end

  def create
    recipe = current_user.recipes.create(recipe_params)
    redirect_to recipe
  end

  private

  def recipe
    Recipe.find(params[:id])
  end

  def user_recipe
    current_user.recipes.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description)
  end
end
