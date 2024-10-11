require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  def login(email, password)
    visit new_session_path
    fill_in "email", with: email
    fill_in "password", with: password

    click_on "Log in"

    assert_selector "span", text: "You have been logged in"
  end
end
