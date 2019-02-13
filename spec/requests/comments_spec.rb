require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before do
    @user1 = User.create(email: "name@mail.com", password: "secret")
    @user2 = User.create(email: "name2@mail.com", password: "secret1")
    @article = Article.create!(title: "First Article", body: "Lorem ipsum dolor sit amet.", user: @user1)
  end

  describe "POST /artiles/:id/comment" do
    context 'with a non signed in user' do
      before do
        post "/articles/#{@article.id}/comments", params: { comment: {body: "Awesome blog"}}
      end
      it "redirects the user to the sign in page" do
        flash_message = "Please sign in or sign up first"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq flash_message
      end
    end

    context "with a signed in user" do
      before do
        login_as(@user1)
        post "/articles/#{@article.id}/comments", params: { comment: {body: "Awesome blog"}}
      end
      it "allows user to comment successfully" do
        flash_message = "Comment has been saved."
        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq 302
        expect(flash[:notice]).to eq flash_message
      end
    end
  end
end
