require 'test_helper'

module CoinMarketCap
  module Api
    class ClientTest < Minitest::Test
      def setup
        CoinMarketCap::Api.config.reset!
        CoinMarketCap::Api.logger.reset!
        @client = Client.new
      end

      def test_endpoint_is_set_by_default
        assert !@client.endpoint.nil?
      end

      def test_user_agent_configuration_set_by_default
        assert_equal "CoinMarketCap Ruby Client/#{CoinMarketCap::VERSION}", @client.user_agent
      end

      def test_faraday_connection_is_cached_to_allow_persistent_adapters
        first = @client.send(:connection)
        second = @client.send(:connection)
        assert_equal first, second
      end

      def test_nil_logger_is_set_by_default
        assert_nil @client.logger.instance
        assert !@client.send(:connection).builder.handlers.include?(::Faraday::Response::Logger)
      end

      def test_default_client_attributes_are_set
        CoinMarketCap::Api::Config::Client::ATTRIBUTES.each do |key|
          assert_equal @client.send(key), CoinMarketCap::Api::Config::Client.send(key)
        end
      end

      def test_attributes_set_with_custom_settings
        CoinMarketCap::Api::Config::Client::ATTRIBUTES.each do |key|
          client = Client.new(key => 'custom')
          assert client.send(key) != CoinMarketCap::Api::Config::Client.send(key)
          assert_equal 'custom', client.send(key)
        end
      end

      def test_global_config_sets_user_agent_and_api_key
        CoinMarketCap::Api.configure do |config|
          config.user_agent = 'custom/user-agent'
          config.api_key = 'my-api-key'
        end

        client = Client.new
        assert_equal 'custom/user-agent', client.user_agent
        assert_equal 'my-api-key', client.api_key

        connection_headers = client.send(:connection).headers
        assert_equal connection_headers, connection_headers.merge(
          'Accept' => 'application/json; charset=utf-8',
          'User-Agent' => 'custom/user-agent',
          'X-CMC_PRO_API_KEY' => 'my-api-key'
        )
      end

      def test_directly_assigning_logger_sets_logger
        logger = Logger.new(STDOUT)

        CoinMarketCap::Api.logger = logger
        client = Client.new
        assert_equal logger, client.logger.instance
      end

      def test_assigning_logger_via_configure_sets_logger
        logger = Logger.new(STDOUT)

        CoinMarketCap::Api.configure.logger = logger
        client = Client.new
        assert_equal logger, client.logger.instance
      end

      def test_passing_logger_at_initialization_sets_logger
        logger = Logger.new(STDOUT)

        client = Client.new(logger: logger)
        assert_equal logger, client.logger.instance
      end

      def test_can_overwrite_a_set_logger
        logger = Logger.new(STDOUT)

        CoinMarketCap::Api.logger = logger
        client = Client.new(logger: nil)
        assert_nil client.logger.instance
      end

      def test_when_assigning_a_config_initialize_sets_logger_and_creates_connection
        logger = Logger.new(STDOUT)
        opts = { bodies: true }
        proc_arg = proc {}

        CoinMarketCap::Api.logger do |log_config|
          log_config.instance = logger
          log_config.options = opts
          log_config.proc = proc_arg
        end

        client = Client.new
        assert_equal logger, client.logger.instance
        assert_equal opts, client.logger.options
        assert_equal proc_arg, client.logger.proc
        assert client.send(:connection).builder.handlers.include?(::Faraday::Response::Logger)
      end

      def test_resetting_test_does_not_reset_the_client
        CoinMarketCap::Api.configure { |config| config.user_agent = 'custom/user-agent' }
        client = Client.new

        CoinMarketCap::Api.config.reset!
        assert_equal 'custom/user-agent', client.user_agent
      end

      def test_new_config_effects_only_next_client
        old_client = Client.new
        CoinMarketCap::Api.configure { |config| config.user_agent = 'custom/user-agent-2' }
        assert Client.new.user_agent != old_client.user_agent
      end

      def test_should_not_allow_client_to_reset
        assert_raises(NoMethodError) { Client.new.reset! }
      end

      def test_raises_error_when_client_makes_request_without_token
        client = Client.new

        assert_raises CoinMarketCap::Errors::PermissionDeniedError do
          VCR.use_cassette('client/access_denied') do
            client.get 'cryptocurrency/map'
          end
        end
      end
    end
  end
end
