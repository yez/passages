require 'lib/route_collection'

module Roots
  class RoutesController < ActionController::Base
    layout false

    def routes
      @route_collection = RouteCollection.new(Rails.application.routes.routes)
    end
  end
end
