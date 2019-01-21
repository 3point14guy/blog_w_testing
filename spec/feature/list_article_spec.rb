require 'rails_helper'

RSpec.feature "List Articles" do
  before do
    user = User.create!(email: "name@mail.com", password: "secret", password_confirmation: "secret")
    @article1 = Article.create(title: "First Article", body: "Lorem ipsum dolor sit amet.", user: user)
    @article2 = Article.create(title: "Second Article", body: "Pirate ipsum is more fun.", user: user)
  end

  scenario "List all articles when visiting root" do
    visit '/'
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario "A user has no articles when visiting root" do
    Article.delete_all
    visit '/'
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within("h3#no-articles") do
      expect(page).to have_content("No Articles have been created.")
    end
  end
end
