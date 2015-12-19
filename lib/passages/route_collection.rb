require_relative 'route'

module Passages
  class RouteCollection
    include Enumerable

    attr_reader :routes

    def initialize(_routes)
      @routes = _routes.reject { |r| r.internal? }
    end

    def each(&block)
      Array(routes).each(&block)
    end

    private

    def main_app_name
      Rails.application.class.name
    end
  end
end
