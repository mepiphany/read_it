class ArticlesController < ApplicationController

  before_action :find_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path, notice: "Article Created!"
    else
      flash[:alert] = "Article wasn't Created!"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "Article Updated!"
    else
      flash[:alert] = "Article wasn't Updated!"
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Article Deleted!"
  end

  private

  def article_params
    params.require(:article).permit([:title, :body, :user_id])
  end

  def find_article
    @article = Article.find(params[:id])
  end

end
