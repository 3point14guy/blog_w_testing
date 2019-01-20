require 'rails_helper'

RSpec.feature 'Creating Articles' do
  scenario 'A user creates a new article' do
    visit '/'
    click_link 'New Article'
    fill_in 'Title', with: "A Capybara Test Article"
    fill_in 'Body', with: "most of these methods here are capybara."
    click_button 'Post Article'

    expect(page).to have_content("Article has been posted.")
    expect(page.current_path).to eq(articles_path)
  end
end
