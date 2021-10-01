require 'test_helper'

module Coinmarketcap
  module Api
    module Config
      class LoggerTest < Minitest::Test
        def setup
          CoinMarketCap::Api.logger.reset!
        end

        def test_default_values_are_set
          assert_nil CoinMarketCap::Api.logger.instance
          assert_equal CoinMarketCap::Api.logger.options, {}
          assert_nil CoinMarketCap::Api.logger.proc
        end

        def test_logger_can_be_set_directly
          setup_logger
          assert_nil CoinMarketCap::Api.logger.instance
          CoinMarketCap::Api.logger = @logger
          assert_equal @logger, CoinMarketCap::Api.logger.instance
        end

        def test_logger_config_can_be_set_directly
          setup_logger
          CoinMarketCap::Api.logger.instance = @logger
          CoinMarketCap::Api.logger.options = @opts
          CoinMarketCap::Api.logger.proc = @proc_arg

          assert_equal @logger, CoinMarketCap::Api.logger.instance
          assert_equal @opts, CoinMarketCap::Api.logger.options
          assert_equal @proc_arg, CoinMarketCap::Api.logger.proc
        end

        def test_logger_config_can_be_set_via_block
            setup_logger
            CoinMarketCap::Api.logger do |logger|
              logger.instance = @logger
              logger.options = @opts
              logger.proc = @proc_arg
            end

            assert_equal @logger, CoinMarketCap::Api.logger.instance
            assert_equal @opts, CoinMarketCap::Api.logger.options
            assert_equal @proc_arg, CoinMarketCap::Api.logger.proc
        end

        def setup_logger
          @logger = Logger.new(STDOUT)
          @opts = { bodies: true }
          @proc_arg = proc {}
        end
      end
    end
  end
end
