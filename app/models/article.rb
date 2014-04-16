require 'open-uri'

class Article < ActiveRecord::Base

  def self.find_articles(url)
    file = open(url)
    regex = /<p>-- (.*)\(<a href="(http.?:\/\/.*\.[a-z]{2,3}\/)(.*)">(.*)<\/a>\).*<\/p>/
    new_articles = file.scan(regex)
    new_articles.each do |article|
      site = Site.find_by_url(article[1])
      if site.length == 0
        site = Site.create(title:article[3], url: article[1])
      end
      article = Article.find_by_subdomain(article[2])
      Article.create(title: article[0], subdomain: article[2], site_id: site.id)
    end
  end 

end
