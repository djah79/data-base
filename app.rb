require 'bundler'
Bundler.require
require 'open-uri'

=begin
require_relative 'lib/game'
require_relative 'lib/player'
=end
$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/scrapper' #plus besoin de préciser le path exact

a = Scrapper.new()
	a.town_with_url
	#a.save_as_JSON
	#a.save_as_spreadsheet
	a.save_as_csv
binding.pry
