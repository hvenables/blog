require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  def setup
    login(users(:first).email, "password")
  end

  test "create an article" do
    visit root_path

    click_on "New Article"

    fill_in "article_title", with: "Test Title"
    fill_in "article_summary", with: test_summary
    fill_in_rich_text_area "article_content", with: "Test Content"

    click_on "Create article"

    assert_selector "h1", text: "Test Title"
    assert_selector "div", text: "Test Content"
  end

  test "update an article" do
    visit articles_path

    click_on articles(:first).title
    click_on "Edit"

    fill_in "article_title", with: "Updated Title"
    fill_in_rich_text_area "article_content", with: "Updated Content"

    click_on "Update article"

    assert_selector "h1", text: "Updated Title"
    assert_selector "div", text: "Updated Content"
  end

  private

  def test_summary
    "Test Summary" * 126
  end
end
