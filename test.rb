require 'rubygems'
require 'nokogiri'
require 'open-uri'

def scrap
  list = {}
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  links = page.css("a")
  news_links = page.css("a").select{|link| link['class'] == "lientxt"}
  news_links.each{|link|
   url = "http://annuaire-des-mairies.com#{link['href'] }"
   link.each {|email|
    page = Nokogiri::HTML(open(url))
    email = page.css("/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    list.merge!(lien_url: url, email: email)
  }
  puts list
}

end
scrap
