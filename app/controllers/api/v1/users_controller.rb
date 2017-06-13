module Api
  module V1
    class UsersController < BaseController
      def create
        render json: create_user, status: :created
      end

      private

      def create_user
        sign_up(user_params)
      end

      def user_params
        params.require(:user).permit(:username, :email, :password)
      end
    end
  end
end
