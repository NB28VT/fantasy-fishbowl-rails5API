require "rails_helper"

RSpec.describe 'POST /api/v1/login', type: :request do
  context "with valid login params" do
    it "returns a 200 response" do
      user = create(:user)

      post "/api/v1/login", params: {users: {email: user.email, password: user.password}}

      expect(response.body).to eq("yeah")
      expect(response).to have_http_status(200)
    end

    it "returns an authorization token in the header" do

    end

    it "returns valid authorization token" do

    end
  end

  context "with invalid login params" do
    it "returns a 401 unauthrozied response" do

    end
  end


end
