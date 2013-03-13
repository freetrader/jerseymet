class PagesController < ApplicationController
  def home
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    url = "http://aviationweather.gov/adds/dataserver_current/httpparam?dataSource=tafs&requestType=retrieve&format=xml&stationString=EGJJ&hoursBeforeNow=4"
    doc = Nokogiri::XML(open(url))
    taf = doc.xpath("//TAF[1]/raw_text")
    @taf = taf.inner_text
    
    cloudlevel = doc.xpath("//TAF[1]/forecast/sky_condition[@sky_cover='BKN']/@cloud_base_ft_agl")
    cloudlevel = cloudlevel.inner_text
    cloudlevel = cloudlevel.to_i
    
    if cloudlevel>200
        @flystatus =  "Jersey looks like it flyable - cloud level is " + cloudlevel.to_s + " feet above the runway"

      else
        @flystatus = "Jersey is not flyable today - cloud level is BKN " + cloudlevel.to_s + " feet above the runway"

    end
  end
end
