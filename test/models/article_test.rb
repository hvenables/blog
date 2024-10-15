require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "article requires a title" do
    assert_not Article.new(summary: "Test").valid?
  end

  test "article requires a summary" do
    assert_not Article.new(title: "Test").valid?
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
    article.published_at = '0'

    assert_nil article.published_at
  end
end
