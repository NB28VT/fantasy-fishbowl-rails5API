class AuthenticationController < ApplicationController
  # Skip global auth request, this controller is for signing in
  skip_before_action :authenticate_request

  def authenticate
    # raise AuthenticationError, "Shit borked here"
    token = UserAuthenticator.new(params[:email], params[:password]).generate_auth_token
    render json: {token: token}, status: 200
  rescue AuthenticationError => e
    render json: {errors: e.message}, status: 401
  end

end
