module CoinMarketCap
  module Resources
    class Resource < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
    end
  end
end
