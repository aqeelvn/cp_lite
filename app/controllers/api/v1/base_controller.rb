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
        AccessToken.find(token: token) || GuestToken.new
      end
    end
  end
end
