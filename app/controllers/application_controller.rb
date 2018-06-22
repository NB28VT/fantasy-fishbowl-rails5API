class ApplicationController < ActionController::API
  before_action :authenticate_request
  include ActionController::Serialization
  # attr_reader :current_user

  class AuthenticationError < StandardError; end

  def test_route
    render json: {message: "Success!"}, status: 200
  end

  private

  def authenticate_request
    @current_user = Services::RequestAuthenticator.new(request.headers).authenticate
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
