class LikesController < ApplicationController
  before_action :set_user_id, only: :create

  def create
    article = Article.friendly.find(params[:article_id])
    Like.create!(uuid: cookies[:user_id], article: article)
  end

  private

  def set_user_id
    unless cookies[:user_id]
      cookies[:user_id] = { value: SecureRandom.uuid, expires: 1.year.from_now, httponly: true }
    end
  end
end
