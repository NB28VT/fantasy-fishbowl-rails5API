class TestController < ApplicationController
  def test_route
    render json: {signin: "Success!"}, status: 200
  end
end
