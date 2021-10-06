module CoinMarketCap
  module Resources
    class Cryptocurrency < Resource
      property 'id'
      property 'name'
      property 'symbol'
      property 'rank'
      property 'slug'
      property 'is_active'
      property 'status'
      property 'first_historical_data'
      property 'last_historical_data'
      property 'platform', transform_with: lambda { |v|
        CoinMarketCap::Resources::Platform.new(v) unless v.nil?
      }
    end
  end
end
