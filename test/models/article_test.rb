require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "article requires a title" do
    article = Article.new

    assert_not article.valid?
    assert_equal article.errors.full_messages.sole, "Title can't be blank"
  end

  test "article requires a summary if published" do
    article = Article.new(title: "Test", content: "test", published_at: Time.current)

    assert_not article.valid?
    assert_equal(
      article.errors.full_messages.to_sentence,
      "Summary can't be blank and Summary is too short (minimum is 150 characters)"
    )
  end

  test "article requires content if published" do
    article = Article.new(title: "Test", summary: "a" * 151, published_at: Time.current)

    assert_not article.valid?
    assert_equal article.errors.full_messages.sole, "Content can't be blank"
  end

  test "#published is true when published at timestamp" do
    assert Article.new(published_at: Time.current).published
  end

  test "#published is false when published at timestamp" do
    assert_not Article.new(published_at: nil).published
  end

  test "#tag_names returns an array of tag names" do
    article = articles(:published)
    assert_equal article.tag_names, ["ruby", "another"]
  end
end
