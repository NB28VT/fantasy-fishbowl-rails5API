class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    # Devise helper:
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
