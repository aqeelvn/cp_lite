module Api
  module V1
    class LikesController < BaseController
      before_action :require_login
      def create
        like = RecipeLiking.new(user: current_user, recipe:recipe).run
        render json:like, status: :created
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
