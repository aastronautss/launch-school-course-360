require 'json'
require 'faraday'

class RequestFailed < StandardError; end

class PokeClient
  def initialize(http_client = Faraday.new)
    @http_client = http_client
  end

  def find_pokemon(identifier)
    url = "http://pokeapi.co/api/v2/pokemon/#{identifier.downcase}"
    data = get url
  end

  private

  def get(url, params = {})
    response = @http_client.get url, params
    require 'pry'; binding.pry
    raise RequestFailed unless response.success?

    JSON.load response.body
  rescue Faraday::Error => e
    raise RequestFailed, e.message, e.backtrace
  end
end

def find_me_a(opts = {})
  PokeClient.new.find_pokemon opts[:pokemon]
end

if $0 == __FILE__
  identifier = ARGV[0]
  puts find_me_a pokemon: identifier
end
