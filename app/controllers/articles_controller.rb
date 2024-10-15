class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

  def show
    articles = user_signed_in? ? Article : Article.published
    @article = articles.friendly.find(params[:id])
  end

  def index
    @articles = Article.published.order(published_at: :desc).first(10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(
      content: TrixPreProcessor.new(article_params[:content]).process,
      **article_params.except(:content)
    )

    if @article.save
      redirect_to article_path(@article), notice: "Article has been created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.friendly.find(params[:id])
  end

  def update
    @article = Article.friendly.find(params[:id])
    @article.assign_attributes(
      content: TrixPreProcessor.new(article_params[:content]).process,
      **article_params.except(:content)
    )

    if @article.save
      redirect_to article_path(@article), notice: "Article has been updated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :sub_title, :summary, :content, :published)
  end
end
