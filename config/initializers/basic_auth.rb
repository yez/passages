module Passages
  def username
    ENV['passages_username'] || ENV['PASSAGES_USERNAME'] || 'username'
  end

  def password
    ENV['passages_password'] || ENV['PASSAGES_PASSWORD'] || 'password'
  end

  def no_auth?
    Passages.config.no_auth?
  end

  module_function :username, :password, :no_auth?
end
