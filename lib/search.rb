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

  def command(selected)
    case selected
    when '/n'
      puts
      search_movies
    when /[0-9]/
      Launchy.open(@movie.hash[selected.to_s])
      @movie.stop = !@movie.stop
      sleep 2
    when '/s'
      @movie.stop = !@movie.stop
    when '/b'
      @movie.count -= 20
      search_movies
    else
      puts "\ncommand #{selected} does not exist, insert a real command please"
      command(gets.chomp.strip)
    end
  end
end
