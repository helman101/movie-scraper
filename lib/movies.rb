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
end
