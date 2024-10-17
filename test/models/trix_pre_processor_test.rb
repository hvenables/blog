require "test_helper"

class TrixPreProcessorTest < ActiveSupport::TestCase
  test "matches and inserts a <code> block to a <pre> tag" do
    str = "<pre>def test= 1 + 1</pre>"
    expected = "<pre><code>def test= 1 + 1</code></pre>"

    assert_equal TrixPreProcessor.new(str).process, expected
  end

  test "Doesn't match if <pre> tag already has a <code> tag" do
    str = "<pre><code>def test= 1 + 1</code></pre>"

    assert_equal TrixPreProcessor.new(str).process, str
  end
end
