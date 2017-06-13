module Api
  module V1
    class CommentsController < BaseController
      before_action :require_login

      def create
        comment = RecipeCommenting.new(user: current_user, recipe:recipe, text: text).run
        render json: comment, status: :created
      end

      private

      def text
        params.require(:comment)[:text]
      end

      def recipe
        Recipe.find(recipe_id)
      end

      def recipe_id
        params[:id]
      end
    end
  end
end
