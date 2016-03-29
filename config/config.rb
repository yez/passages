# Define the Passages namespace
module Passages
  # Central configuration class
  class Config
    attr_accessor :automount
    attr_writer :no_auth

    def no_auth?
      @no_auth.present?
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
