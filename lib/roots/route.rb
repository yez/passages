require 'active_support/core_ext'
require_relative 'mount_route'

module Roots
  class Route < DelegateClass(ActionDispatch::Routing::RouteWrapper)

    def initialize(route)
      super(ActionDispatch::Routing::RouteWrapper.new(route))
    end

    class << self
      def attributes_for_display
        %w[name verb controller action path]
      end

      def from_raw_route(raw_route)
        mount_class = mount_route_class(raw_route)

        if mount_class.nil?
          new(raw_route)
        else
          MountRoute.new(raw_route, mount_class)
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
end
