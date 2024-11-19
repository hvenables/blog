class ArticleForm < ApplicationForm
  attribute :id
  attribute :feature_image

  form_attribute :title
  form_attribute :sub_title
  form_attribute :summary
  form_attribute :content
  form_attribute :published
  form_attribute :tag_names

  attr_reader :article
  alias_method :record, :article

  delegate :errors, to: :article

  def initialize(...)
    super

    @article = find_or_initialize_article
  end

  def submit!
    @article.assign_attributes(
      title:,
      sub_title:,
      summary:,
      published:,
      feature_image:,
      tags:,
    )
    @article.content = parsed_content if parsed_content
    @article.save!
  end

  def persisted?
    self.id.present?
  end

  private

  def find_or_initialize_article
    if id.present?
      Article.friendly.find(id)
    else
      Article.new
    end
  end

  def parsed_content
    case content
    when String
      TrixPreProcessor.new(content).process
    end
  end

  def tags
    return [] unless tag_names

    tag_names.compact_blank.map do |name|
      Tag.find_or_initialize_by(name: name)
    end
  end
end
