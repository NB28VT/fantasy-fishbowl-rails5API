require "rails_helper"
RSpec.describe "/api/v1/signup", type: :request do
  it "returns 200" do
    post "/api/v1/signup", params: {user: {email: "happy@happy.com", password: "12344", password_confirmation: "12344"}}

    expect(response.code).to eq(200)
  end

  it "returns a new user" do
    post "/api/v1/signup", params: {user: {email: "happy@happy.com", password: "12344", password_confirmation: "12344"}}

    expect(response.body).to match_schema('user')
  end
end
