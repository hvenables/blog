require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "article requires a title" do
    assert_not Article.new(summary: "Test").valid?
  end

  test "article requires a summary" do
    assert_not Article.new(title: "Test").valid?
  end
end
