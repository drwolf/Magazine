require 'open-uri'
require 'nokogiri'

class Article < ActiveRecord::Base

  def self.find_articles(url)
    download = open(url)
    file = download.read
    regex = /<p>-- (.*)\(<a href="((http.?:\/\/.*\.[a-z]{2,3}\/).*)">(.*)<\/a>\).*<\/p>/
    article_links = file.scan(regex)
    article_links.each do |link|
      site = Site.find_by_url(link[2])
      site = Site.create(title:link[3], url: link[2]) unless site
      article = Article.find_by_url(link[1])
      article = Article.create(title: link[0], url: link[1], site_id: site.id) unless article
      begin
        article_html = Nokogiri::HTML(open(article.url))
      rescue
        return
      end
      images = article_html.search("article").search("img")
      images = article_html.search(".post-body").search("img") if images.size == 0
      images = article_html.search(".post").search("img") if images.size == 0
      images = article_html.search(".entry-content").search("img") if images.size == 0
      if images.length != 0
        puts images
      else
        puts "OH NO!"
      end
    end
  end

end