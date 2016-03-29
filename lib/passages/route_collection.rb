require_relative 'route'

module Passages
  # Enumerable to iterate through and select only external routes
  #  for the main application to display
  class RouteCollection
    include Enumerable

    attr_reader :routes

    def initialize(routes)
      @routes = routes.reject(&:internal?)
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
