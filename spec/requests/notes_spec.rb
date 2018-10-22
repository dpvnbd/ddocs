require 'rails_helper'

describe "Notes" do
  context "when on home page" do
    before do
      @user = create :user
      @another_user = create :user
      @user_note = create :note, user: @user
      @another_note = create :note, user: @another_user
      sign_in @user
      get "/notes"
    end

    subject(:notes) { assigns(:notes) }

    it "shows notes index page" do
      expect(response).to render_template('notes/index')
    end

    it "includes notes of logged in user" do
      expect(notes).to include(@user_note)
    end

    it "includes notes of other user" do
      expect(notes).to include(@another_note)
    end
  end
end