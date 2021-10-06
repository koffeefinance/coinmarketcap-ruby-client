require 'date'

module CoinMarketCap
  module Resources
    class Resource < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared

      def self.iso8601_date(timestamp)
        Date.iso8601(timestamp)
      end
    end
  end
end
