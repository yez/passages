require 'active_support/core_ext'

module Roots
  class Route < DelegateClass(ActionDispatch::Routing::RouteWrapper)
    attr_accessor :app_name

    class << self
      def attributes_for_display
        %w[name verb controller action path]
      end
    end
  end
end
