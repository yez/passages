module Passages
  def username
    ENV['passages_username'] || ENV['PASSAGES_USERNAME'] || 'username'
  end

  def password
    ENV['passages_password'] || ENV['PASSAGES_PASSWORD'] || 'password'
  end

  def no_auth=(no_auth)
    @no_auth = no_auth
  end

  def no_auth?
    @no_auth.nil? || @no_auth
  end

  module_function :username, :password, :no_auth=, :no_auth?
end
