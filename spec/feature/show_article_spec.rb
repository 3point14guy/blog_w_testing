require 'rails_helper'

RSpec.feature "Show Article" do
  before do
    @article = Article.create(title: "BDD article", body: "Behavior driven developemnt is more robust than unit testing bc we are testing how we expect users to interact with the app.")
  end

  scenario "clicking article title takes user to article show page" do
    visit '/'
    click_link(@article.title)
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
  end
end
