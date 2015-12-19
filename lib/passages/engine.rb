module Passages
  class Engine < ::Rails::Engine
     isolate_namespace Passages

     initializer 'passages', before: :load_config_initializers do |app|
      Rails.application.routes.prepend do
        mount Passages::Engine, at: '/passages'
      end
    end
  end
end
