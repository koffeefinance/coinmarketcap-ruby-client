require 'vcr'
require 'webmock/minitest'

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes/coinmarketcap'
  config.hook_into :webmock
  config.debug_logger = $stderr
  config.filter_sensitive_data('test-coinmarketcap-api-key') { ENV['COINMARKETCAP_API_KEY'] }
end
