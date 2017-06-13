module Api
  module V1
    class RecipesController < BaseController
      def index
        render json: {
            recipes: recipes.page(page),
            count: recipes.count,
            page: page
          },
          status: :ok
      end

      private

      def recipes
        Recipe.all
      end

      def page
        params[:page] || 1
      end
    end
  end
end
