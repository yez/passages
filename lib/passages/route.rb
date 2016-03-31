require 'active_support/core_ext'
require 'action_dispatch/routing/inspector'
require_relative 'mount_route'

module Passages
  # Main DelegateClass used for decoration and discerning if a route is
  #  a "regular" route or a mount route
  class Route < DelegateClass(ActionDispatch::Routing::RouteWrapper)
    def initialize(route)
      super(ActionDispatch::Routing::RouteWrapper.new(route))
    end

    class << self
      def attributes_for_display
        %w(name verb controller action path)
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
        klass = app_class(route.app)

        klass if klass.ancestors.include?(Rails::Engine)
      rescue
        nil
      end

      def app_class(route_app)
        if route_app.class == Class
          route_app
        else
          route_app.try(:app)
        end
      end
    end
  end
end
