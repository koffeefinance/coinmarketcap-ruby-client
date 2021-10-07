module CoinMarketCap
  module Endpoints
    module Cryptocurrency
      def map(options = {})
        response = get('cryptocurrency/map', {}.merge(options))
        response['data'].map { |row| CoinMarketCap::Resources::Cryptocurrency.new(row) }
      end

      def info(options = {})
        response = get('cryptocurrency/info', {}.merge(options))
        puts 'hello'
        puts response['data']
        response['data'].map do |key, value|
          [key, CoinMarketCap::Resources::Metadata.new(value)]
        end.to_h
      end
    end
  end
end
