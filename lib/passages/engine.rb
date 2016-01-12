module Passages
  class Engine < ::Rails::Engine
    isolate_namespace Passages

    initializer 'passages', after: :load_config_initializers do |app|
      if Passages.config.automount
        Rails.application.routes.prepend do
          mount Passages::Engine, at: '/passages'
        end
      end
    end
  end
end
