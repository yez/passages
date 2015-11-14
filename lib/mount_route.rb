module Roots
  class MountRoute < DelegateClass(ActionDispatch::Routing::RouteWrapper)
    def initialize(route)
      @route = route
      super(ActionDispatch::Routing::RouteWrapper.new(route))
    end

    def engine_name
      @route.app.app.name
    end
  end
end
