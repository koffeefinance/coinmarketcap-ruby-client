require 'test_helper'

module Coinmarketcap
  module Api
    module Config
      class ClientTest < Minitest::Test
        def setup
          CoinMarketCap::Api.config.reset!
          CoinMarketCap::Api.configure.logger.reset!
        end

        def test_default_end_point
          assert_equal CoinMarketCap::Api.config.endpoint, 'https://pro-api.coinmarketcap.com/v1'
        end

        def test_configure_sets_endpoint
          CoinMarketCap::Api.configure do |config|
            config.endpoint = 'updated'
          end

          assert_equal 'updated', CoinMarketCap::Api.config.endpoint
        end

        def test_logger_config_update_actually_updates_config
          assert_nil CoinMarketCap::Api.config.logger.instance
          logger = Logger.new(STDOUT)

          CoinMarketCap::Api.configure { |config| config.logger = logger }
          assert_equal logger, CoinMarketCap::Api.config.logger.instance
        end

        def test_logger_config_update_actually_updates_api_logger
          assert_nil CoinMarketCap::Api.logger.instance
          logger = Logger.new(STDOUT)

          CoinMarketCap::Api.configure { |config| config.logger = logger }
          assert_equal logger, CoinMarketCap::Api.logger.instance
        end

        def test_api_logger_update_actually_updates_api_logger
          assert_nil CoinMarketCap::Api.logger.instance
          logger = Logger.new(STDOUT)

          CoinMarketCap::Api.logger = logger
          assert_equal logger, CoinMarketCap::Api.logger.instance
        end
      end
    end
  end
end
