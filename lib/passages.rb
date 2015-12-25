module Passages
end

require './config/initializers/basic_auth_methods'

if defined? Rails
  require 'passages/engine'
  require 'controllers/passages/routes_controller'
end
