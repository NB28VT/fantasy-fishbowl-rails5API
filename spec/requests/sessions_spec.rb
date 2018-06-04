require "rails_helper"

RSpec.describe "API Sessions", type: :request do
  describe "POST /api/v1/sessions" do
    context "with a valid username and password" do
      it "signs in the user" do
        user = create(:user)

        post "/api/v1/sessions", params: {email: user.email, password: user.password}

        expect(current_user).to eq(user)
      end
    end

    context "without a valid username" do
      it "returns an error message"
    end

    context "without a valid password" do
      it "returns an error message"
    end

  end

end
