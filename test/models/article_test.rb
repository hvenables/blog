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
    assert_equal article.errors.full_messages.sole, "Summary can't be blank"
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

  test "#published= will set published at if value is '1'" do
    freeze_time do
      article = Article.new(published: "1")

      assert_equal article.published_at, Time.current
    end
  end

  test "#published_at= will set published at to nil unless value is '1'" do
    article = Article.new(published_at: Time.current)
    article.published_at = "0"

    assert_nil article.published_at
  end
end
