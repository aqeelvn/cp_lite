class CommentsController < ApplicationController
  before_action :require_login

  def create
    recipe.comments.create(comment_params)
    redirect_to recipe
  end

  private

  def recipe
    Recipe.find(params[:recipe_id])
  end

  def comment_params
    params.require(:comment).permit(:text).merge(user:current_user)
  end
end
