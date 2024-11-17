require "test_helper"

class ArticleFormTest < ActiveSupport::TestCase
  test "sets attributes correctly" do
    form = ArticleForm.new(
      title: "New Article",
      sub_title: "Sub Title",
      summary: "a" * 250,
      content: "This is some content",
      published: "1",
      tag_names: ["Ruby", "JS"]
    )
  end

  test "updates the attributes" do
    form = ArticleForm.new(
      id: articles(:published).id,
      title: "New Article",
      sub_title: "Sub Title",
      summary: "a" * 250,
      content: "This is some content",
      published: "1",
      tag_names: ["Ruby", "JS"]
    )
  end
end
