
  require 'dotenv'
  require 'nokogiri'
  require 'open-uri'

  def download_page (link)
 page = Nokogiri::HTML(open(link))
 	return page
 end

 def get_depute_email(depute_url)
 	current_depute


_page = download_page(depute_url)
 	current_mail = current_depute_page.xpath('/html/body/div/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
 	return current_mail
 end

# puts get_depute_email("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036")
def get_deput_urls
 	page = download_page("http://www.assemblee-nationale.fr/qui/xml/regions.asp?legislature=14")
 	depute_urls = Array.new()
	depute_names = Array.new()
 	puts depute_names = page.xpath('//a[@class = "dep2"]')
 	
 	i = 0
  	depute_names.each do |current_depute_name|
  		
   		current_depute_name = current_depute_name['href']
		current_depute_name = current_depute_name[1 .. current_depute_name.length]
   		puts depute_urls[i] = "http://www.assemblee-nationale.fr/#{current_depute_name}"  
   		 i += 1
  	end

  return depute_urls
end


def get_deputehall_names
 	page = download_page("http://www.assemblee-nationale.fr/qui/xml/regions.asp?legislature=14")
 	depute_names = Array.new()
 	depute2_names = Array.new()
 	first_name = Array.new()
 	last_name = Array.new()
 	last2_name = Array.new()
 	i = 0 
 	page.xpath('//a[@class = "dep2"]').each do |currrent_depute_names|
 		depute_names[i] = currrent_depute_names.text
 		first_name[i] = depute_names[i].scan(/\w+/)[1]
 		last_name[i] = (depute_names[i].scan(/\w+/)[2, depute_names.length])

 	 i += 1
 	end
return depute2_names[first_name,last_name]
end
puts get_deputehall_names

def depute_with_url
	final_depute_with_url= Hash.new()
	depute_with_url = Array.new() 
	i = 0
	j = 0

	get_deputehall_urls.each do |current_depute_url|
		depute_with_url[i] = get_deputehall_names[j]
		depute_with_url[i+1] = get_deputehall_email(current_depute_url)
		i += 2
		j += 1
	end
	
 return Hash[[*depute_with_url]]
end
get_deputehall_names