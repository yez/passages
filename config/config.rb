module Passages
  class Config
    attr_accessor :automount
    attr_writer :no_auth

    def no_auth?
      !!@no_auth
    end
  end

  def config
    @config ||= Config.new
  end

  def configure
    yield config
  end

  module_function :config, :configure
end
