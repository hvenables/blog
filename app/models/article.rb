class Article < ApplicationRecord
  extend FriendlyId

  has_one_attached :feature_image
  has_rich_text :content

  friendly_id :title, use: :slugged

  validates :title, presence: true

  with_options if: :published? do
    validates :summary, :content, presence: true
    validates :summary, length: { minimum: 150, maximum: 450 }, if: :summary
  end

  scope :published, -> { where.not(published_at: nil) }
  scope :unpublished, -> { where(published_at: nil) }

  def published
    published_at.present?
  end
  alias_method :published?, :published

  def published=(value)
    if value == "1"
      self.published_at = Time.current
    else
      self.published_at = nil
    end
  end
end
