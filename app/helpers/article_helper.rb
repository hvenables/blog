module ArticleHelper
  def social_image(article)
    if article.feature_image.present?
      rails_blob_url(article.feature_image.variant(resize_to_fit: [1200, 630]))
    end
  end
end
