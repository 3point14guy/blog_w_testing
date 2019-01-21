require 'rails_helper'

RSpec.feature "Delete Article" do
  before do
    user = User.create!(email: "name@mail.com", password: "secret", password_confirmation: "secret")
    login_as(user)
    @article = Article.create(title: "First Article", body: "Lorem ipsum dolor sit amet.", user: user)
  end

  scenario "User deletes an article successfully" do
    visit "/"
    click_link @article.title
    click_link "Delete Article"
    expect(page).to have_content("Article deleted successfully.")
    expect(page.current_path).to eq(articles_path)
  end
end
