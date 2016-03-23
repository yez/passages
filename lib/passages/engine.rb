module Passages
  class Engine < ::Rails::Engine
    isolate_namespace Passages

    initializer "passages.assets.precompile" do |app|
      app.config.assets.precompile += %w(application.css application.js)
    end

    initializer 'passages', after: :load_config_initializers do |app|
      if Passages.config.automount
        Rails.application.routes.prepend do
          mount Passages::Engine, at: '/passages'
        end
      end

      unless Passages.config.no_auth?
        Passages::RoutesController.http_basic_authenticate_with name: Passages.username, password: Passages.password
      end
    end
  end
end
