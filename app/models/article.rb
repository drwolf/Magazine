require 'open-uri'

class Article < ActiveRecord::Base

  def self.find_articles(url)
    file = open(url)
    regex = /<p>-- (.*)\(<a href="(http.?:\/\/.*\.[a-z]{2,3}\/)(.*)">(.*)<\/a>\).*<\/p>/
    new_articles = file.scan(regex)
    new_articles.each do |article|

      Article.create(title: article[0], subdomain: )
    end
  end 

end
