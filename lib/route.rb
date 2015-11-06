require 'active_support/core_ext'

module Roots
  class Route
    attr_accessor :app_name
    attr_reader :wrapped

    def initialize(wrapped_route)
      @wrapped = wrapped_route
    end

    delegate :name, :verb, :controller, :action, :path, to: :wrapped
  end
end
