require 'rails_helper'

describe "#sign_in" do
  subject(:user) {create :user}

  context "when correct credentials" do
    it "authenticates user successfully" do
      post "/auth/sign_in", params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:ok)
    end
  end

  context "when incorrect credentials" do
    it "return unauthorized status" do
      post "/auth/sign_in", params: { email: user.email + 'a', password: user.password }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

describe "#post" do

end

