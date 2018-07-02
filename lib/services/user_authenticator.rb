module Services
  class AuthenticationError < StandardError; end
  class UserAuthenticator
    def initialize(email, password)
      @email = email
      @password = password
    end

    def generate_auth_token
      user = get_user
      raise AuthenticationError, "Invalid Credentials" unless user.present?
      return Services::JsonWebToken.new.encode(user_id: user.id)
    end

    private

    def get_user
      Rails.logger.info @email
      user = User.find_by(email: @email)
      return user if user && user.authenticate(@password)
      return nil
    end
  end
end
