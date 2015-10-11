module Roots
  class RouteCollection
    include Enumerable

    attr_reader :application_routes, :engine_routes

    def initialize(app_routes:, eng_routes: [])
      @application_routes = []
      @engine_routes = []

      app_routes.each do |route|
        name = main_app_name
        add_route_to_array(application_routes, route, name)
      end

      eng_routes.each do |eng_hash|
        eng_hash[:routes].each do |route|
          name = eng_hash[:engine]
          add_route_to_array(engine_routes, route, name)
        end
      end
    end

    def attributes_for_display
      %w[name verb controller action path]
    end

    def add_route_to_array(array, route, name)
      wrapped = ActionDispatch::Routing::RouteWrapper.new(route)
      array << { app: name, route: wrapped } unless wrapped.internal?
    end

    def each(&block)
      (app_routes + engine_routes).each(&block)
    end

    def main_app_name
      Rails.application.class.name
    end
  end
end
