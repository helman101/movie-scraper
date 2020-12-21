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

  def search_movies
    @movie.movies if @movie.results == true
    if @movie.results == true
      puts '
Select your movie with a number
Or use /n (Next) or /b (Back) commands to change pages
And use /s (Stop) to exit'
    end
    command(gets.chomp.strip) if @movie.results == true
  end
end
