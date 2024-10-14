class TrixPreProcessor
  def initialize(content)
    @content = content
  end

  def process
    insert_code_blocks
  end

  private

  def insert_code_blocks
    @content.gsub(/<pre>(?![\s\S]*<code>)([\s\S]*?)<\/pre>/, '<pre><code>\1</code></pre>')
  end
end
