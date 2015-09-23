require 'lib/formatter'

module Roots
  class RoutesController < ActionController::Base
    layout false

    def routes
      rails_routes = Rails.application.routes.routes
      inspector = ActionDispatch::Routing::RoutesInspector.new(rails_routes)
      formatter = Formatter.new
      result = inspector.format(formatter)
    end
  end
end
