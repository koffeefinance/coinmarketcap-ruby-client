module CoinMarketCap
  module Resources
    class Quote < Resource
      property 'price'
      property 'volume_24h'
      property 'volume_24h_reported'
      property 'volume_7d'
      property 'volume_7d_reported'
      property 'volume_30d'
      property 'volume_30d_reported'
      property 'market_cap'
      property 'market_cap_dominance'
      property 'fully_diluted_market_cap'
      property 'percent_change_1h'
      property 'percent_change_24h'
      property 'percent_change_7d'
      property 'percent_change_30d'
      property 'percent_change_60d'
      property 'percent_change_90d'
      property 'last_updated', transform_with: ->(v) { iso8601_date(v) }
    end
  end
end
