require "json"
require "faraday"

class SymbolNotFound < StandardError; end
class RequestFailed < StandardError; end

# MarkitClient provides access to the Markit On Demand API
class MarkitClient
  def initialize(http_client=Faraday.new)
    @http_client = http_client
  end

  # Get the most recent price for a stock symbol
  # Returns the price as a Float.
  # Raises RequestFailed if the request fails.
  # Raises SymbolNotFound if a price cannot be found for the provided symbol.
  def last_price(stock_symbol)
    url = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json"
    data = make_request(url, symbol: stock_symbol)
    price = data["LastPrice"]

    raise SymbolNotFound.new(data["Message"]) unless price

    price
  end

  private

  # Make an HTTP GET request using @http_client
  # Returns the parsed response body.
  def make_request(url, params={})
    response = @http_client.get(url, params)
    JSON.load(response.body)
  rescue Faraday::Error => e
    raise RequestFailed, e.message, e.backtrace
  end
end

def calculate_value(symbol, quantity)
  markit_client = MarkitClient.new
  price = markit_client.last_price(symbol)
  price * quantity.to_i
end

if $0 == __FILE__
  symbol, quantity = ARGV
  puts calculate_value(symbol, quantity)
end
