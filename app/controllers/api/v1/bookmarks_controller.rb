module Api
  module V1
    class BookmarksController < BaseController
      before_action :require_login

      def create
        bookmark = RecipeBookmarking.new(user: current_user, recipe:recipe).run
        render json:bookmark, status: :created
      end

      def destroy
        current_user.remove_bookmark(recipe)
        head :ok
      end

      private

      def recipe
        Recipe.find(recipe_id)
      end

      def recipe_id
        params[:id]
      end
    end
  end
end
