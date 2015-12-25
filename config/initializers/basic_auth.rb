module Passages
  def username
    ENV['passages_username'] || 'username'
  end

  def password
    ENV['passages_password'] || 'password'
  end

  module_function :username, :password
end
