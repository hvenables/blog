require "test_helper"

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")                        # Run in headless mode
  options.add_argument("--no-sandbox")                      # Required for CircleCI
  options.add_argument("--disable-dev-shm-usage")          # Required for CircleCI
  options.add_argument("window-size=1400x1400")            # Optional: Ensures proper window size
  options.add_argument("--remote-debugging-port=9222")     # Optional: Debugging for CI issues
  options.add_argument("--disable-gpu")                    # Optional: Helps avoid rendering issues
  options.add_argument("--disable-software-rasterizer")    # Optional

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :headless_chrome

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
