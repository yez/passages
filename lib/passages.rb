$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
$LOAD_PATH << File.dirname(__FILE__) + '/../config'

module Passages
end

require 'initializers/basic_auth'

if defined? Rails
  require 'passages/engine'
  require 'controllers/passages/routes_controller'
end
