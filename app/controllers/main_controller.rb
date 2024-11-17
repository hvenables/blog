class MainController < ApplicationController
  def index
    @articles = Article.includes(:likes).published.order(published_at: :desc).last(4)
  end
end
