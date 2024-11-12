class LikesController < ApplicationController
  before_action :set_anonymous_user_id
  before_action :load_article

  def create
    Like.create!(uuid: cookies[:uuid], article: @article)
  end

  def destroy
    Like.find_by!(uuid: cookies[:uuid], article: @article).destroy!
  end

  private

  def load_article
    @article = Article.friendly.find(params[:article_id])
  end
end
