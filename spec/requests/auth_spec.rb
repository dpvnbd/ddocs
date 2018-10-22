require 'rails_helper'

describe "Authentication" do
  subject(:user) {create :user}

  context "when logged in" do
    before do
      sign_in user
    end

    it "shows home page" do
      get "/"
      expect(response).to render_template('notes/index')
    end
  end

  context "when logged out" do
    it "redirects from root page to sign in" do
      get "/"
      expect(response).to redirect_to('/users/sign_in')
    end
  end

  context "when logging in" do
    it "redirects to root after successful sign in" do

      post "/users/sign_in", params: {user: {email: user.email, password: user.password}}
      expect(response).to redirect_to('/')
    end

    it "shows sign in page after unsuccessful sign in" do
      post "/users/sign_in", params: {user: {email: user.email, password: user.password + '12'}}
      expect(response).to render_template 'devise/sessions/new'
    end
  end
end