module Passages
  # Special DelegateClass of ActionDispatch's RouteWrapper for
  #  an Engine's mount route. i.e. /passages for this Engine
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
