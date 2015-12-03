require 'active_support/core_ext'

module Roots
  class EngineRoute < DelegateClass(ActionDispatch::Routing::RouteWrapper)
    attr_reader :engine_name

    def initialize(raw_route, engine_name)
      @engine_name = engine_name

      super(ActionDispatch::Routing::RouteWrapper.new(raw_route))
    end
  end
end
