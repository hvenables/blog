require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  test "create an article" do
    login(users(:first).email, "password")

    click_on "Admin"
    click_on "New Article"

    fill_in "article_title", with: "Test Title"
    fill_in "article_summary", with: test_summary
    fill_in_rich_text_area "article_content", with: "Test Content"

    click_on "Create article"

    assert_selector "h1", text: "Test Title"
    assert_selector "div", text: "Test Content"
  end

  test "update an article" do
    login(users(:first).email, "password")

    click_on "Admin"
    click_on articles(:first).title
    click_on "Edit"

    fill_in "article_title", with: "Updated Title"
    fill_in_rich_text_area "article_content", with: "Updated Content"

    click_on "Update article"

    assert_selector "h1", text: "Updated Title"
    assert_selector "div", text: "Updated Content"
  end

  test "Layout of published article" do
    visit articles_path

    click_on "Published Article"
    assert_selector "h1", text: "Published Article"
    assert_selector "h3", text: "This is a subtitle of the main one"
    assert_selector "h5", text: "Published: #{articles(:published).published_at.to_date.to_formatted_s(:long)}"
    assert_selector "span.tag", text: "Ruby"
  end

  test "Like an article" do
    visit articles_path

    click_on "Published Article"
    find("button.like").click

    assert_selector ".like-count", text: "1"
  end

  test "renders errors" do
    login(users(:first).email, "password")

    click_on "Admin"
    click_on "New Article"

    fill_in "article_summary", with: test_summary
    fill_in_rich_text_area "article_content", with: "Test Content"

    click_on "Create article"
    assert_selector "div.error-message", text: "Your title can't be blank."
  end

  private

  def test_summary
    "Test Summary" * 126
  end
end
