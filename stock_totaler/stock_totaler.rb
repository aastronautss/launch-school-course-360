require "json"
require "faraday"

class SymbolNotFound < StandardError; end
class RequestFailed < StandardError; end

def calculate_value(symbol, quantity)
  url = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json"

  http_client = Faraday.new
  response = nil

  begin
    response = http_client.get(url, symbol: symbol)
  rescue Faraday::Error::ConnectionFailed => e
    raise RequestFailed, e.message, e.backtrace
  end

  data = JSON.load(response.body)

  price = data["LastPrice"]
  raise SymbolNotFound, data['Message'] unless price
  price.to_f * quantity.to_i
end

symbol, quantity = ARGV
puts calculate_value symbol, quantity if $0 == __FILE__
