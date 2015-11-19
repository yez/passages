require 'active_support/core_ext'

module Roots
  class Route < DelegateClass(ActionDispatch::Routing::RouteWrapper)
    attr_accessor :app_name

    def initialize(raw_route)
      if mount_class = mount_route_class(raw_route)
        MountRoute.new(raw_route, mount_class)
      else
        super(ActionDispatch::Routing::RouteWrapper.new(raw_route))
      end
    end

    class << self
      def attributes_for_display
        %w[name verb controller action path]
      end
    end

    private

    def mount_route_class(route)
      route_app = route.app

      app = if route_app.class == Class
        route_app
      else
        route_app.try(:app)
      end

      app if app.ancestors.include?(Rails::Engine)
    rescue
      nil
    end
  end
end
