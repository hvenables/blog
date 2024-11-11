class LikesController < ApplicationController
  before_action :set_anonymous_user_id

  def create
    @article = Article.friendly.find(params[:article_id])
    Like.create!(uuid: cookies[:uuid], article: @article)
  end

  def destroy
    @article = Article.friendly.find(params[:article_id])
    Like.find_by!(uuid: cookies[:uuid], article: @article).destroy
  end
end
