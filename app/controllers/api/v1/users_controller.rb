module Api
  module V1
    class UsersController < BaseController
      def create
        user = create_user
        if user.valid?
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
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
