# frozen_string_literal: true

require "rails_helper"

describe "Authentication" do
  describe "#sign_in" do
    subject(:user) { create :user }

    context "when correct credentials" do
      it "authenticates user successfully" do
        post "/auth/sign_in", params: { email: user.email, password: user.password }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when incorrect credentials" do
      it "return unauthorized status" do
        post "/auth/sign_in", params: { email: user.email + "a", password: user.password }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "#create" do
    context "when correct params" do
      let(:params) { { name: "Test Test", email: "aa@aa.aa", password: "123456", password_confirmation: "123456" } }

      before do
        post "/auth", params: params
      end

      it "responds with ok" do
        expect(response).to have_http_status(:ok)
      end

      it "creates a user record" do
        expect(User.find_by(email: params[:email])).to be_present
      end
    end
  end

  describe "#destroy" do
    subject(:user) { create(:user) }

    context "when user is signed in" do
      sign_in :user

      before do
        delete "/auth/sign_out"
      end

      it "responds with ok on sign out" do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "#update" do
    subject(:user) { create :user }

    context "when updating name and image" do
      sign_in :user

      let(:name) { "Test Name" }
      let(:image) { "base64string" }

      before do
        put "/auth", params: { name: name, image: image }
        user.reload
      end

      it "updates user name" do
        expect(user.name).to eq(name)
      end

      it "updates user image" do
        expect(user.image).to eq(image)
      end
    end
  end
end
