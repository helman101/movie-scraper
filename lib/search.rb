require 'nokogiri'
require 'launchy'
require 'open-uri'
require_relative 'movies'

class Search
  attr_reader :doc, :movie

  def initialize(movie_url)
    @doc = Nokogiri::HTML(URI.open("https://123moviesfree.net/search-query/#{movie_url}"))
    @movie = Movie.new(@doc)
  end
end
