class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_anonymous_user_id, only: :show

  def show
    articles = user_signed_in? ? Article : Article.published
    @article = articles.friendly.find(params[:id])

    fresh_when @article
  end

  def index
    @pagy, @articles = pagy_countless(Article.includes(:likes).published.order(published_at: :desc))

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def feed
    @articles = Article.includes(:tags).published.order(published_at: :desc).last(10)

    if stale?(last_modified: @articles.maximum(:updated_at), etag: @articles, public: true)
      respond_to do |format|
        format.xml { render layout: false, formats: [:rss] }
      end
    end
  end

  def new
    @article_form = ArticleForm.new
  end

  def create
    @article_form = ArticleForm.new(article_params)

    if @article_form.save
      redirect_to article_path(@article_form.article), notice: "Article has been created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article_form = ArticleForm.new(id: params[:id])
  end

  def update
    @article_form = ArticleForm.new(id: params[:id], **article_params)
    if @article_form.save
      redirect_to article_path(@article_form.article), notice: "Article has been updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.unpublished.friendly.find(params[:id])

    if @article.destroy
      redirect_to admin_dashboard_path, notice: "Article deleted"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :sub_title, :summary, :content, :published, :feature_image, tag_names: [])
  end
end
