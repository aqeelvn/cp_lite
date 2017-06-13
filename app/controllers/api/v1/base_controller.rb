module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session

      protected

      def current_user
        access_token.user
      end

      def token
        request.headers['X-Access-Token']
      end

      def access_token
        AccessToken.find_by(token: token) || GuestToken.new
      end

      def logged_in?
        !current_user.nil?
      end

      def required_login
        unless logged_in?
          render json:nil, status: :unauthorized
        end
      end
    end
  end
end
