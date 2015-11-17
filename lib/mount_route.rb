module Roots
  class MountRoute < DelegateClass(ActionDispatch::Routing::RouteWrapper)
    def initialize(route, app)
      @route = route
      @app = app
      super(ActionDispatch::Routing::RouteWrapper.new(route))
    end

    def engine_name
      @app.name
    end
  end
end
