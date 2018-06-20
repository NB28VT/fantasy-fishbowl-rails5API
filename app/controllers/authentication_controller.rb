class AuthenticationController < ApplicationController
  # Skip global auth request, this controller is for signing in
  skip_before_action :authenticate_request

  def authenticate
    token = Services::UserAuthenticator.new(params[:email], params[:password]).generate_auth_token
    render json: {token: token}, status: 200
  rescue AuthenticationError => e
    render json: {errors: e.message}, status: 401
  end

end
