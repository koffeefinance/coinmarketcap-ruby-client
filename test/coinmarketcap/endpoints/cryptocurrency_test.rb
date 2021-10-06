require 'test_helper'

module CoinMarketCap
  module Endpoints
    class CryptocurrencyTest < Minitest::Test
      def setup
        @client = CoinMarketCap::Api::Client.new
      end

      def test_map_retrieves_a_list_cryptocurrencies
        VCR.use_cassette('map/latest_cryptocurrencies') do
          map = @client.map
          assert !map.nil?
          assert_equal 6974, map.length
        end
      end

      def test_map_response_parsed_as_cyrptocurrency_object
        VCR.use_cassette('map/eth') do
          map = @client.map(symbol: 'ETH')
          assert_equal 1, map.length

          eth = map.first
          assert_equal 1027, eth.id
          assert_equal 'Ethereum', eth.name
          assert_equal 'ETH', eth.symbol
          assert_equal 2, eth.rank
          assert_equal 'ethereum', eth.slug
          assert_equal 1, eth.is_active
          assert_nil eth.status
          assert_equal '2015-08-07T14:49:30.000Z', eth.first_historical_data
          assert_equal '2021-10-05T02:19:02.000Z', eth.last_historical_data
          assert_nil eth.platform
        end
      end

      def test_map_response_parses_platform
        VCR.use_cassette('map/usdt') do
          map = @client.map(symbol: 'USDT')
          assert_equal 1, map.length

          first = map.first
          platform = first.platform
          assert_equal 1027, platform.id
          assert_equal 'Ethereum', platform.name
          assert_equal 'ETH', platform.symbol
          assert_equal 'ethereum', platform.slug
          assert_equal '0xdac17f958d2ee523a2206206994597c13d831ec7', platform.token_address
        end
      end
    end
  end
end
