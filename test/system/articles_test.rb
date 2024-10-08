require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  test "create an article" do
    visit root_path

    click_on "New Article"

    fill_in "article_title", with: "Test Title"
    fill_in "article_summary", with: "Test Summary"
    fill_in_rich_text_area "article_content", with: "Test Content"

    click_on "Create article"

    assert_selector "h1", text: "Test Title"
    assert_selector "div", text: "Test Content"
  end

  test "update an article" do
    visit root_path

    click_on "Blog"
    click_on "Edit"

    fill_in "article_title", with: "Updated Title"
    fill_in_rich_text_area "article_content", with: "Updated Content"

    click_on "Update article"

    assert_selector "h1", text: "Updated Title"
    assert_selector "div", text: "Updated Content"
  end
end
