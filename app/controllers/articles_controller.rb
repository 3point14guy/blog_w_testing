class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, except: [:index, :new, :create]
  def index
    @articles = Article.all
  end

  def show
    @comment = @article.comments.build
    @comments = @article.comments
  end

  def destroy
    unless @article.user == current_user
      flash[:alert] = "You can only delete your own article."
      redirect_to root_path
    else
      if @article.destroy
        flash[:success] = "Article deleted successfully."
        redirect_to articles_path
      else
        flash.now[:danger] = "There was a problem deleting the article."
      end
    end
  end

  def edit
    unless @article.user == current_user
      flash[:alert] = "You can only edit your own article."
      redirect_to root_path
    end
  end

  def update
    unless @article.user == current_user
      flash[:alert] = "You can only edit your own article."
      redirect_to root_path
    else
      if @article.update(article_params)
        flash[:success] = "Article has been updated."
        redirect_to @article
      else
        flash.now[:danger] = "Article did not update."
        render :edit
      end
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article has been posted."
      redirect_to articles_path
    else
      flash.now[:danger] = "Article not posted."
      render :new
    end
  end

protected

  def resource_not_found
    message = "The article you are looking for could not be found"
    flash[:alert] = message
    redirect_to root_path
  end

private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end


end
