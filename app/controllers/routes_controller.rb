require 'lib/route_collection'

module Roots
  class RoutesController < ActionController::Base
    layout false

    def routes
      @route_collection = RouteCollection.new(app_routes: application_routes, eng_routes: engine_routes)
    end

    private

    def engine_routes
      ::Rails::Engine.subclasses.map do |engine|
        { engine: engine.class.name, routes: [*engine.routes.routes.routes] }
      end.flatten
    end

    def application_routes
      [*Rails.application.routes.routes]
    end
  end
end
