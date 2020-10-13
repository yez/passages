module Passages
  # Engine class, subclass of Rails::Engine and the heart of
  #  namespace isolation, asset precompiliation hooks and
  #  authentication concerns.
  class Engine < ::Rails::Engine
    isolate_namespace Passages

    # Necessary for rake assets:precompile in a main application
    #  to compile this Engine's assets as well
    initializer 'passages.assets.precompile' do |app|
      app.config.assets.precompile += %w[passages/application.css passages/application.js]
    end

    # Optionally mount the /passages route at an applications top
    #  level.
    #
    # Optionally allow basic authentication
    initializer 'passages', after: :load_config_initializers do
      if Passages.config.automount
        Rails.application.routes.prepend do
          mount Passages::Engine, at: '/passages'
        end
      end

      unless Passages.config.no_auth?
        Passages::RoutesController.http_basic_authenticate_with(
          name: Passages.username,
          password: Passages.password
        )
      end
    end
  end
end
