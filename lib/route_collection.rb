module Roots
  class RouteCollection
    include Enumerable

    attr_reader :application_routes, :engine_routes

    def initialize(app_routes:, eng_routes: [])
      @application_routes = []
      @engine_routes = []

      app_routes.each do |route|
        app_class = route.try(:app).try(:app)
        if app_class.is_a?(Class) && app_class.ancestors.include?(Rails::Engine)
          name = app_class.name
          add_route_to_array(engine_routes, mount_route, name)
        else
          name = main_app_name
          add_route_to_array(application_routes, route, name)
        end
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

    def each(&block)
      (app_routes + engine_routes).each(&block)
    end

    private

    def add_route_to_array(array, route, name)
      wrapped = ActionDispatch::Routing::RouteWrapper.new(route)
      return if wrapped.internal?

      if existing = array.find { |a| a[:app] == name }
        existing[:routes] << wrapped
      else
        array << { app: name, routes: [wrapped] }
      end
    end

    def main_app_name
      Rails.application.class.name
    end
  end
end
