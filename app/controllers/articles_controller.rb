class ArticlesController < ApplicationController
  
  before_action :set_model, only: [:show, :edit, :update, :destroy]

  def index
    s = Article.search do
      fulltext params[:term].to_s
    end
    @articles = s.results
  end

  def new
    @article = Article.new
  end

  def edit
    render "new"
  end

  def update
    @article.update(articles_params)
    redirect_to @article
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def create
    @article = Article.new(articles_params)
    @article.save
    redirect_to @article
  end

  def show
  end

  private

  def articles_params
    params.require(:article).permit(:title, :text)
  end

  def set_model
    @article = Article.find(params[:id])
  end
end
