require "#{Rails.root.join('app/services/user_authenticator.rb')}"

module AuthenticationHelper
  def sign_in_user(user)
    UserAuthenticator.new(user.email, user.password).generate_auth_token
  end
end
