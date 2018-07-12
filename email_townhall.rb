require 'rubygems'
require 'nokogiri'
require 'open-uri'



def get_the_email_of_a_townhal_from_its_webpage(mail)

	page = Nokogiri::HTML(open(mail))

	puts page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text

end

def get_all_the_urls_of_val_doise_townhalls
page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
news_links = page.css("a").select{|link| link['class'] == "lientxt"}
# news_links.each{|link| puts link['href'] }
	news_links.each do |link|
		mail = link['href'].sub(".","")
		puts "http://annuaire-des-mairies.com#{mail}"
	end
end 

  get_all_the_urls_of_val_doise_townhalls
