module CoinMarketCap
  module Api
    module Config
      module Client
        ATTRIBUTES = %i[
          endpoint
          api_key
          user_agent
        ].freeze

        class << self
          include Config::Logger::Accessor

          attr_accessor(*ATTRIBUTES)

          def reset!
            self.endpoint = 'https://pro-api.coinmarketcap.com/v1'
            self.api_key = ENV['COINMARKETCAP_API_KEY']
            self.user_agent = "CoinMarketCap Ruby Client/#{CoinMarketCap::VERSION}"
          end
        end

        module Accessor
          def configure
            block_given? ? yield(Config::Client) : Config::Client
          end

          def config
            Config::Client
          end
        end
      end
    end
  end
end

CoinMarketCap::Api::Config::Client.reset!
