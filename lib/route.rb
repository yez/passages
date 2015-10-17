module Roots
  class Route
    attr_accessor :name, :wrapped

    def initialize(wrapped_route)
      wrapped = wrapped_route
    end

    def name
      wrapped.name
    end

    def verb
      wrapped.verb
    end

    def controller
      wrapped.controller
    end

    def action
      wrapped.action
    end

    def path
      wrapped.path
    end
  end
end
