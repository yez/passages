module Roots
  class MountRoute
    def initialize(route)
      @route = route
      @wrapped = ActionDispatch::Routing::RouteWrapper.new(route)
    end

    def engine_name
      @route.app.app.name
    end

    def internal?
      @wrapped.internal?
    end

    def path
      @wrapped.path
    end
  end
end
