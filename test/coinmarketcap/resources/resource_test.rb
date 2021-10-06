require 'test_helper'
require 'date'

module CoinMarketCap
  module Resources
    class ResourceTest < Minitest::Test
      def test_is8601_date_parses_timestamp
        timestamp = '2015-02-25T13:34:26.000Z'
        assert_equal Date.iso8601(timestamp), CoinMarketCap::Resources::Resource.iso8601_date(timestamp)
      end
    end
  end
end
