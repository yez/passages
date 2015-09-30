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
  end
end
