module Passages
  def username
    ENV['passages_username'] || 'username'
  end

  def password
    ENV['passages_password'] || 'password'
  end

  def no_auth=(no_auth)
    @no_auth = no_auth
  end

  def no_auth?
    @no_auth.nil? || @no_auth
  end

  module_function :username, :password, :no_auth=, :no_auth?
end
