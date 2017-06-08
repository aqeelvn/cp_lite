class BookmarksController < ApplicationController
  before_action :require_login

  def create
    bookmark = RecipeBookmarking.new(user: current_user, recipe:recipe).run
    current_user.bookmark(recipe)
    redirect_to recipe
  end

  def destroy
    current_user.remove_bookmark(recipe)
    redirect_to recipe
  end

  private

  def recipe
    Recipe.find(recipe_id)
  end

  def recipe_id
    params[:id]
  end
end