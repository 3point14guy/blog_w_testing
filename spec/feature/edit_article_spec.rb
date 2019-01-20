require 'rails_helper'

RSpec.feature "Edit Article" do
  before do
    @article = Article.create(title: "First Article", body: "Lorem ipsum dolor sit amet.")
  end

  scenario "user edits an article successfully" do
    visit "/"
    click_link @article.title
    click_link "Edit Article" 
    fill_in "Title", with: "Updated Article Title"
    fill_in "Body", with: "Updated article text here."
    click_button "Update Article"
    expect(page).to have_content("Article has been updated.")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario "user unsuccessfully edits an article" do
    visit "/"
    click_link @article.title
    click_link "Edit Article"
    fill_in "Title", with: ""
    fill_in "Body", with: "Updated article text here."
    click_button "Update Article"
    expect(page).to have_content("Article did not update.")
    expect(page.current_path).to eq(article_path(@article))
  end

end
