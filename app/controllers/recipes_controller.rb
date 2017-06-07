class RecipesController < ApplicationController
  before_action :require_login, except: %i(show)

  def show
    @recipe = Recipe.find(params[:id])
    @comments = @recipe.comments.includes(:user)
  end
end
