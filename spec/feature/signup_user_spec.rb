require 'rails_helper'

RSpec.feature "User Signup" do
  scenario "with valid credentials" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "name@mail.com"
    fill_in "Password", with: "secretest"
    fill_in "Password confirmation", with: "secretest"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"
    # expect(page).to have_content("There was an error during sign up.")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    # expect(page).to have_content("Password confirmation is required")
  end
end
