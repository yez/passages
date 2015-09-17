module Roots
  class RoutesController < ActionController::Base
    layout false

    def routes
      render 'routes'
    end
  end
end
