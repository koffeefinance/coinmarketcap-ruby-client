module CoinMarketCap
  module Endpoints
    module Cryptocurrency
      def map(options = {})
        response = get('cryptocurrency/map', {}.merge(options))
        response.map { |row| CoinMarketCap::Resources::Cryptocurrency.new(row) }
      end
    end
  end
end
