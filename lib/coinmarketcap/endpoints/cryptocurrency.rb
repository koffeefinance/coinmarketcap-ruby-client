module CoinMarketCap
  module Endpoints
    module Cryptocurrency
      def map(options = {})
        response = get('cryptocurrency/map', options)
        response['data'].map { |row| CoinMarketCap::Resources::Cryptocurrency.new(row) }
      end

      def info(options = {})
        response = get('cryptocurrency/info', options)
        response['data'].map do |key, value|
          [key, CoinMarketCap::Resources::Metadata.new(value)]
        end.to_h
      end

      def listings_latest(options = {})
        response = get('cryptocurrency/listings/latest', options)
        response['data'].map { |row| CoinMarketCap::Resources::Listing.new(row) }
      end
    end
  end
end
