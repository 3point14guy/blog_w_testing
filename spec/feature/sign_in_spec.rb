require 'rails_helper'

RSpec.feature "User Signin" do
  before do
    @user = User.create(email: "name@mail.com", password: "secret", password_confirmation: "secret")
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@user.email}")
    expect(page).not_to have_link("Sign up")
    expect(page).not_to have_link("Sign in")
  end
end
