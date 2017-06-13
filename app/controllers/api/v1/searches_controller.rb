module Api
  module V1
    class SearchesController < ApplicationController
      def show
        query = params.fetch(:search, {})[:query]
        results = Search.new(query: query).run
        render json: {
            results: results.page(page),
            count: results.count,
            page: page
          },
        status: :ok
      end

      private

      def page
        params[:page] || 1
      end
    end
  end
end
