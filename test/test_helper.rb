ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start :rails
end

require "rails/test_help"

require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]


module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
