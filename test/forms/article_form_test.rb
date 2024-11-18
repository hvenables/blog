require "test_helper"

class ArticleFormTest < ActiveSupport::TestCase
  test "creates a new article" do
    assert_changes -> { Article.count } do
      form = ArticleForm.new(
        title: "New Article",
        sub_title: "Sub Title",
        summary: "a" * 250,
        content: "This is some content",
        published: "1",
      )
      assert form.save!
    end
  end

  test "updates the attributes of an existing article" do
    article = articles(:published)
    new_title = "New Title"
    new_sub_title = "New Sub Title"
    new_summary = "a" * 250
    new_content = "This is some content"

    form = ArticleForm.new(
      id: article.id,
      title: new_title,
      sub_title: new_sub_title,
      summary: new_summary,
      content: new_content,
    )

    assert form.save!

    article.reload

    assert_equal article.title, new_title
    assert_equal article.sub_title, new_sub_title
    assert_equal article.summary, new_summary
    assert_includes article.content.to_s, new_content
  end

  test "creates tags if they dont exist" do
    article = articles(:published)
    form = ArticleForm.new(
      id: article.id,
      tag_names: ["JS"]
    )

    assert_changes -> { Tag.count } do
      assert form.save!
    end

    assert_equal article.reload.tags, [Tag.last]
  end
end
