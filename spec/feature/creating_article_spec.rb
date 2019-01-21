require 'rails_helper'

RSpec.feature 'Creating Articles' do
  before do
    @user = User.create!(email: "name@mail.com", password: "secret", password_confirmation: "secret")
    login_as(@user)
  end

  scenario 'A user creates a new article' do
    visit '/'
    click_link 'New Article'
    fill_in 'Title', with: "A Capybara Test Article"
    fill_in 'Body', with: "most of these methods here are capybara."
    click_button 'Create Article'

    expect(Article.last.user).to eq(@user)
    expect(page).to have_content("Article has been posted.")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by: #{@user.email}")
  end

  scenario "A user fails to create a new article" do
    visit '/'
    click_link 'New Article'
    fill_in 'Title', with: ""
    fill_in 'Body', with: ""
    click_button 'Create Article'

    expect(page).to have_content("Article not posted.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
