# app/views/articles/feed.rss.builder
xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "vena.codes"
    xml.link articles_url
    xml.description "Lastest articles from the mind of Harry Venables"
    xml.updated @articles.first.published_at.to_formatted_s(:iso8601)

    @articles.each do |article|
      xml.item do
        xml.title       article.title
        xml.link        article_url(article)
        xml.description article.summary
        xml.pubDate     article.published_at.to_formatted_s(:iso8601)
        xml.guid        article_url(article), isPermaLink: "true"
      end
    end
  end
end
