module Support
  module AuthenticationHelper
    def sign_in_user(user)
      Services::UserAuthenticator.new(user.email, user.password).generate_auth_token
    end
  end
end
