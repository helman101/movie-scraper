require 'nokogiri'
require 'open-uri'

class Movie
  attr_reader :doc, :name, :quality, :url
  attr_accessor :count, :stop, :results, :hash

  def initialize(doc)
    @doc = doc
    @count = 0
    @stop = false
    @results = true
    @name = @doc.css('div.ml-item span.mli-info h2')
    @quality = @doc.css('div.ml-item span.mli-quality')
    @url = @doc.css('div.ml-item a.ml-mask')
    @hash = {}
  end

  def movies
    @hash = {}
    if (@name.length - @count).positive? && (@quality.length - @count).positive?
      @name.length.times do
        puts "#{@count + 1}. Movie: #{@name[@count].text}"
        puts "   Quality: #{@quality[@count].text.strip}\n\n"
        @hash[(@count + 1).to_s] = "https://123moviesfree.net#{@url[@count]['href'].chomp.strip}"
        @count += 1
        break if (@count % 10).zero?
      end
    else
      @results = false
      puts 'No results found.'
    end
  end
end
