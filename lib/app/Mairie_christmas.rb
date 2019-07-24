require 'bundler'
Bundler.require
require 'open-uri'

 def download_page (link)
 page = Nokogiri::HTML(open(link))
 	return page
 end

 def get_townhall_email(townhall_url)
 	current_town_page = download_page(townhall_url)
 	current_mail = current_town_page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
 	return current_mail
 end
#puts get_townhall_email("https://www.annuaire-des-mairies.com/95/avernes.html")

 def get_townhall_urls
 	page = download_page("https://www.annuaire-des-mairies.com/val-d-oise.html")
 	townhall_urls = Array.new()
	townhall_names = Array.new()
 	townhall_names = page.xpath('//a[@class="lientxt"]')
 	
 	i = 0
  	townhall_names.each do |current_town_name|
  		
   		current_town_name = current_town_name['href']
		current_town_name = current_town_name[1, current_town_name.length]
   		townhall_urls[i] = "https://www.annuaire-des-mairies.com#{current_town_name}"  
   		 i += 1
  	end

  return townhall_urls
end

#puts get_townhall_urls



def get_townhall_names
 	page = download_page("https://www.annuaire-des-mairies.com/val-d-oise.html")
 	townhall_names = Array.new()
 	i = 0 
 	page.xpath('//a[@class = "lientxt"]').each do |currrent_townhall_names|
 		townhall_names[i] = currrent_townhall_names.text
 	 i += 1
 	end
return townhall_names
end


def town_with_url
	final_town_with_url= Hash.new()
	town_with_url = Array.new() 
	i = 0
	j = 0

	get_townhall_urls.each do |current_town_url|
		town_with_url[i] = get_townhall_names[j]
		town_with_url[i+1] = get_townhall_email(current_town_url)
		i += 2
		j += 1
	end
	final_town_with_url = Hash[*town_with_url]
 return final_town_with_url
end
puts town_with_url
