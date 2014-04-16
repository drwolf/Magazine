require 'open-uri'

class Article < ActiveRecord::Base

  def self.find_articles(url)
    file = open(url)
    regex = /<p>-- (.*)\(<a href="(.*)">(.*)<\/a>\).*<\/p>/
  end 

end
