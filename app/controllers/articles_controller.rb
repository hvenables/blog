class ArticlesController < ApplicationController
  def show
    @article = Article.friendly.find(params[:id])
  end

  def index
    @articles = Article.with_rich_text_content.first(10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(
      title: article_params[:title],
      sub_title: article_params[:sub_title],
      summary: article_params[:summary],
      content: wrap_code_blocks(article_params[:content]),
    )

    if @article.save
      redirect_to article_path(@article), notice: "Article has been created"
    else
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :sub_title, :summary, :content)
  end

  def wrap_code_blocks(content)
    content.gsub(/<pre>([\s\S]*?)<\/pre>/, '<pre><code>\1</code></pre>')
  end
end
