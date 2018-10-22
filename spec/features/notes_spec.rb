require 'rails_helper'

describe "creating notes", js: true, type: :feature do
  before :each do
    @user = create :user
    login_as(@user)
  end

  it "shows submitted note" do
    visit '/notes'
    note_body =  'test-note'
    expect(page).not_to have_content(note_body)

    within("#new-note") do
      fill_in 'note-body', with:note_body
    end
    click_button 'Save'
    expect(page).to have_content "#{@user.email}: #{note_body}"
  end

  it "broadcasts notes to other window of same user" do
    note_body =  'test-note'
    visit '/notes'
    # submit form in new window
    new_window = open_new_window
    within_window new_window do
      visit '/notes'
      within("#new-note") do
        fill_in 'note-body', with:note_body
      end
      click_button 'Save'
    end

    switch_to_window(windows.first)
    expect(page).to have_content "#{@user.email}: #{note_body}"
  end
end