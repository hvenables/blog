class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

  def show
    @article = Article.friendly.find(params[:id])
  end

  def index
    @articles = Article.order(created_at: :desc).first(10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(
      title: article_params[:title],
      sub_title: article_params[:sub_title],
      summary: article_params[:summary],
      content: TrixPreProcessor.new(article_params[:content]).process,
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
      title: article_params[:title],
      sub_title: article_params[:sub_title],
      summary: article_params[:summary],
      content: TrixPreProcessor.new(article_params[:content]).process,
    )

    if @article.save
      redirect_to article_path(@article), notice: "Article has been updated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :sub_title, :summary, :content)
  end
end
