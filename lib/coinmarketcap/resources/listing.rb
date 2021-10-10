module CoinMarketCap
  module Resources
    class Listing < Resource
      property 'id'
      property 'name'
      property 'symbol'
      property 'slug'
      property 'cmc_rank'
      property 'num_market_pairs'
      property 'circulating_supply'
      property 'total_supply'
      property 'market_cap_by_total_supply'
      property 'max_supply'
      property 'last_updated', transform_with: ->(v) { iso8601_date(v) }
      property 'date_added', transform_with: ->(v) { iso8601_date(v) }
      property 'tags'
      property 'platform', transform_with: lambda { |v|
        CoinMarketCap::Resources::Platform.new(v) unless v.nil?
      }
      property 'quote', transform_with: lambda { |v|
        v.map do |key, value|
          [key, CoinMarketCap::Resources::Quote.new(value)]
        end.to_h
      }
    end
  end
end
