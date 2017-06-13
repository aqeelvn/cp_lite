module Api
  module V1
    class SessionsController < BaseController
      def create
        user = authenticate_session(session_params)

        if sign_in(user)
          render json: { :access_token => access_token(user) }, status: :created
        else
          render json:nil, status: :unauthorized
        end
      end

      private

      def session_params
        params.require(:session).permit(:email, :password)
      end

      def access_token(user)
        user.access_tokens.first.token
      end
    end
  end
end
