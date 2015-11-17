module Roots
  class Engine < ::Rails::Engine
     isolate_namespace Roots

     initializer 'roots', before: :load_config_initializers do |app|
      Rails.application.routes.prepend do
        mount Roots::Engine, at: '/roots'
      end
    end
  end
end
