module V1
  class StockApi < BaseApi
    resource :stock do
      %w[shops for_publisher sold].each do |action|
        require_relative "stock_api_actions/#{action}"
        include "StockApiActions::#{action.camelize}".constantize
      end
    end
  end
end
