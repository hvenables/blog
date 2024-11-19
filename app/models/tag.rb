class Tag < ApplicationRecord
  has_many :article_tags, dependent: :destroy
  has_many :articles, through: :article_tags, inverse_of: :tags

  normalizes :name, with: ->(name) { name.strip.downcase }
  validates :name, presence: true, uniqueness: true
end
