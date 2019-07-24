
  require 'dotenv'
  require 'nokogiri'
  require 'open-uri'

  def download_page (link)
 page = Nokogiri::HTML(open(link))
 	return page
 end
#all_emails_links = page.xpath("/html/body/div[2]/div[2]/div/div/div[3]/div[2]/table/tbody/tr[1]/td[3]")
#puts page.xpath('//a')
def crypto_name 

final_resul = Array.new()
symbol = Array.new()
price = Array.new()
result = Array.new()
 page = download_page("https://coinmarketcap.com/all/views/all/")
symbol = page.xpath('//td[@class="text-left col-symbol"]')
price = page.xpath('//td[@class="no-wrap text-right"]')
i = 0
j = 0
while i < symbol.length
	result[i] =symbol[j].text
	result[i+1] = price[j].text.scan(/\d/).join('').to_f
	j+= 1
	i += 2

end

final_resul = [Hash[*result]]
end 



print crypto_name



