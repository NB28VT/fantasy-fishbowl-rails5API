class RequestAuthenticator
  def initialize(headers)
    @headers = headers
  end

  def authenticate
    return nil unless auth_headers.present?
    decoded_token = JsonWebToken.new.decode(auth_headers)
    User.find_by(id: decoded_token[:user_id])
  end

  private

  def auth_headers
    @headers["Authorization"]
  end

end
