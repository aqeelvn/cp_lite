module Api
  module V1
    class RecipesController < BaseController
      before_action :require_login, except: [:index]

      def index
        render json: {
            recipes: recipes.page(page),
            count: recipes.count,
            page: page
          },
          status: :ok
      end

      def create
        recipe = RecipeCreate.new(user: current_user, recipe_params: recipe_params).run

        if recipe.persisted?
          render json: recipe, status: :created
        else
          head :unprocessable_entity
        end
      end

      private

      def recipe_params
        params.require(:recipe).
        permit(
          :title,
          :description,
          :cover_image,
          ingredients_attributes: [:name, :id, :_destroy],
          steps_attributes: [:description, :id, :_destroy]
        )
      end

      def recipes
        Recipe.all
      end

      def page
        params[:page] || 1
      end
    end
  end
end
