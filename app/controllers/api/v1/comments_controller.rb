module Api
  module V1
    class CommentsController < BaseController
      before_action :require_login

      def create
        comment = RecipeCommenting.new(user: current_user, recipe:recipe, text: text).run
        render json: comment, status: :created
      end

      def destroy
        comment.destroy
        head :ok
      end

      private

      def text
        params.require(:comment)[:text]
      end

      def recipe
        Recipe.find(recipe_id)
      end

      def comment
        Comment.find(params[:id])
      end

      def recipe_id
        params[:recipe_id]
      end
    end
  end
end
