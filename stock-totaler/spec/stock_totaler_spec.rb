require_relative '../stock_totaler'

require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

RSpec.describe 'stock totaler' do
  it 'calculates stock share value with valid symbol', :vcr do
    total_value = calculate_value 'TSLA', 1
    expect(total_value).to eq(262.08)
  end

  it 'raises an error with an invalid symbol', :vcr do
    expect{ calculate_value 'ZZZZ', 1 }.to raise_error(SymbolNotFound)
  end

  it "handles an exception from Faraday" do
    stub_request(:get, "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json?symbol=ZZZZ").to_timeout

    expect(->{
      calculate_value("ZZZZ", 1)
    }).to raise_error(RequestFailed, /execution expired/)
  end
end
