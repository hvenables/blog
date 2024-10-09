class Article < ApplicationRecord
  has_rich_text :content
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :summary, :content, presence: true
  validates :summary, length: { minimum: 250, maximum: 450 }
end
