require 'rails_helper'

describe "the sign in process", type: :feature do
  before :each do
    @user = create :user
  end

  it "signs me in" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
    end
    click_button 'Log in'
    expect(page).to have_content "#{@user.email} Logout"
  end
end