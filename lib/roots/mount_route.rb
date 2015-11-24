module Roots
  class MountRoute < DelegateClass(ActionDispatch::Routing::RouteWrapper)
    def initialize(route, app)
      @app = app
      super(ActionDispatch::Routing::RouteWrapper.new(route))
    end

    def engine_name
      @app.name
    end
  end
end
