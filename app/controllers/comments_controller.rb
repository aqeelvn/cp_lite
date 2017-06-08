class CommentsController < ApplicationController
  before_action :require_login

  def create
    RecipeCommenting.new(user: current_user, recipe:recipe, text: params.require(:comment)[:text]).run
    redirect_to recipe
  end

  def destroy
    comment_recipe = comment.recipe
    comment.destroy
    redirect_to comment_recipe
  end

  private

  def comment
    Comment.find(params[:id])
  end

  def recipe
    @recipe ||= Recipe.find(params[:recipe_id])
  end

  def comment_params
    params.require(:comment).permit(:text).merge(user:current_user)
  end
end
