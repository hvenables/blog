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
    @article.assign_attributes(assignable_attributes)
    @article.save!
  end

  def persisted?
    self.id.present?
  end

  private

  def assignable_attributes
    {
      title:,
      sub_title:,
      feature_image:,
      summary:,
      content: parsed_content,
      published_at:,
      tags:
    }.compact
  end

  def published_at
    if published == "1"
      article.published_at || Time.current
    end
  end

  def find_or_initialize_article
    if id.present?
      Article.friendly.find(id)
    else
      Article.new
    end
  end

  def parsed_content
    return unless form_content

    TrixPreProcessor.new(form_content).process
  end

  def tags
    return [] unless form_tag_names

    form_tag_names.compact_blank.map do |name|
      Tag.find_or_initialize_by(name: name)
    end
  end
end
