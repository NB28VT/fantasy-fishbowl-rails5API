class ApplicationController < ActionController::API
  # Custom API rendering from here. Might end up with something different:
  # https://medium.com/@mazik.wyry/rails-5-api-jwt-setup-in-minutes-using-devise-71670fd4ed03
  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    # Dunno what they are using this 100 code for
    render json: {
      errors: [
        {
          status: '400',
          message: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end
end
