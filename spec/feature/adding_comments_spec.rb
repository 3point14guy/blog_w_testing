require 'rails_helper'

RSpec.feature "Adding comments to articles" do
  before do
    @user1 = User.create(email: "name@mail.com", password: "secret")
    @user2 = User.create(email: "name2@mail.com", password: "secret1")
    @article = Article.create(title: "First Article", body: "Lorem ipsum dolor sit amet.", user: @user1)
  end

  scenario "permits a signed in user to comment on an article" do
    login_as(@user2)
    visit "/"
    click_link @article.title
    fill_in 'New Comment', with: "Amazing article, dude!"
    click_button 'Add Comment'

    expect(page).to have_content("Comment has been saved.")
    expect(page).to have_content("Amazing article, dude!")
    expect(page.current_path).to eq(article_path(@article.id))
  end
end
