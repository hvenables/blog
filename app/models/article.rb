class Article < ApplicationRecord
  has_rich_text :content
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :summary, :content, presence: true
  validates :summary, length: { minimum: 150, maximum: 450 }

  scope :published, -> { where.not(published_at: nil) }

  def published
    published_at.present?
  end

  def published=(value)
    if value == '1'
      self.published_at = Time.current
    else
      self.published_at = nil
    end
  end
end
