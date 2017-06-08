class LikesController < ApplicationController
  before_action :require_login

  def create
    current_user.like(recipe)
    redirect_to recipe
  end

  def destroy
    current_user.unlike(recipe)
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