$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
$LOAD_PATH << File.dirname(__FILE__) + '/../config'

# Define the Passages namespace module
module Passages
end

require 'initializers/basic_auth'
require 'config'

if defined? Rails
  require 'passages/engine'
  require 'controllers/passages/routes_controller'
end
