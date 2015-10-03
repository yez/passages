module Roots
  class RouteCollection
    include Enumerable

    def initialize(routes)
      @routes = [].tap do |arr|
        routes.each do |route|
          wrapped = ActionDispatch::Routing::RouteWrapper.new(route)
          arr << wrapped unless wrapped.internal?
        end
      end
    end

    def each(&block)
      @routes.each(&block)
    end

    def engine_routes
      if @engine_routes.nil?
        partition_routes
      end

      @engine_routes
    end

    def application_routes
      if @application_routes.nil?
        partition_routes
      end

      @application_routes
    end

    private

    def partition_routes
      @engine_routes, @application_routes = partition(&:engine?)
    end
  end
end
