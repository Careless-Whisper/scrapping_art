require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

@first_name = []
@last_name = []


def get_name
  names = []
    page = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=576'))
    page.css('h2[class = titre_normal]').each do |nom|
    names << nom.text
  end
names.map! { |item| item.delete_prefix("M ") }
names.map! { |item| item.delete_prefix("Mme ") }
names.each { |item| array = item.split(" ")
  @first_name << array[0]
  @last_name << array.drop(1).join(" ")
}
end
get_name



def get_mail
  mail = []

    page = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=576'))
    page.css('a[@href ^="mailto:"]').each do |email|
    mail << email.text.sub(" ", "")

  end

  mail.keep_if { |w| w =~ /assemblee-nationale.fr$/ }
  mail.delete_if {|w| w =~ /secretariat-blanchet/}
  mail.delete_if {|w| w =~ /bureau-m-orphelin/}

  return mail
end
get_mail


def create_hash
 hash = Hash[get_name.zip(get_mail)]
 hash.each do |key, mail|
   puts "#{key} : #{mail}"
 end
end
create_hash
