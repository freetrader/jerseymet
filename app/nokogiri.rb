require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://aviationweather.gov/adds/dataserver_current/httpparam?dataSource=tafs&requestType=retrieve&format=xml&stationString=EGJJ&hoursBeforeNow=4"
doc = Nokogiri::XML(open(url))

#puts doc.at('p').second.text
#puts doc
taf = doc.xpath("//TAF/raw_text")
#puts taf
jerseytaf = taf.first

cloudlevel = doc.xpath("//TAF[1]/forecast/sky_condition[@sky_cover='BKN']/@cloud_base_ft_agl")


cloudlevel = cloudlevel.inner_text
cloudlevel = cloudlevel.to_i

puts cloudlevel 

if cloudlevel>200
    puts "Jersey looks like it flyable - cloud level is " + cloudlevel.to_s + " feet above the runway"

  else
    puts "Jersey is not flyable today - cloud level is BKN " + cloudlevel.to_s + " feet above the runway"

end 


#puts jerseytaf

  
