class Article < ApplicationRecord
  has_rich_text :content
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :summary, presence: true
end
