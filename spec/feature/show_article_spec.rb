require 'rails_helper'

RSpec.feature "Showing Article" do
  before do
    @user1 = User.create!(email: "name1@mail.com", password: "secret", password_confirmation: "secret")
    @user2 = User.create!(email: "name2@mail.com", password: "secret", password_confirmation: "secret")
    @article = Article.create(title: "BDD article", body: "Behavior driven developemnt is more robust than unit testing bc we are testing how we expect users to interact with the app.", user: @user1)
  end

  scenario "to non-signed in user hides edit and delete" do
    visit '/'
    click_link(@article.title)
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "to non-author, signed in user hides edit and delete" do
    login_as(@user2)
    visit '/'
    click_link(@article.title)
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "to signed in author shows edit and delete" do
    login_as(@user1)
    visit '/'
    click_link(@article.title)
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).to have_content "Edit Article"
    expect(page).to have_content "Delete Article"
  end
end
