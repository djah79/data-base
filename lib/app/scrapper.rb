require 'bundler'
Bundler.require
require 'open-uri'

class Scrapper
	attr_accessor :email 


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
		town_with_url = Array.new() 
		i = 0
		j = 0
		get_townhall_urls.each do |current_town_url|
			town_with_url[i] = get_townhall_names[j]
			town_with_url[i+1] = get_townhall_email(current_town_url)
			i += 2
			j += 1
			puts "#{j} email and townhall saved"
		end
		@email = Hash[*town_with_url]
	 #return @email
	end
	def save_as_JSON
		i = 1
		File.open("db/emails.json","w")do |f|
  		f.write(JSON.pretty_generate(@email))
  		puts "#{i} hash saved"
  		i += 1
		end
	end
	def save_as_spreadsheet
		session = GoogleDrive::Session.from_config("config.json")
		ws = session.spreadsheet_by_key("pz7XtlQC-PYx-jrVMJErTcg").worksheets[0]
		tab = @email.to_a
		i=0
		while i<tab.length
			k=(i/2)+1
			ws[k,1] = tab[i]
			ws[k,2] = tab[i+1]
			i += 2
		end
	end
	def save_as_csv
		i = 1
		tab = @email.to_a
		CSV.open("db/emails.csv", "wb") do |f|
			tab.each do |l|
				f << l
				puts "#{i} hash saved"
			end
  		i += 1
		end
	end

end