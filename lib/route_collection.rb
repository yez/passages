module Roots
  class RouteCollection
    include Enumerable

    attr_reader :application_routes, :engine_routes

    def initialize(app_routes:, eng_routes: [])
      @application_routes = []
      @engine_routes = []

      app_routes.each do |route|
        wrapped = ActionDispatch::Routing::RouteWrapper.new(route)
        application_routes << { app: main_app_name, route: wrapped } unless wrapped.internal?
      end

      eng_routes.each do |eng_hash|
        eng_hash[:routes].each do |route|
          wrapped = ActionDispatch::Routing::RouteWrapper.new(route)
          engine_routes << { app: eng_hash[:engine], route: wrapped } unless wrapped.internal?
        end
      end
    end

    def each(&block)
      (app_routes + engine_routes).each(&block)
    end

    def main_app_name
      Rails.application.class.name
    end
  end
end
