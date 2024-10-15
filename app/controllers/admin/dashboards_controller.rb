class Admin::DashboardsController < ApplicationController
  def show
    @articles = Article.unpublished
  end
end
