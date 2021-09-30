module CoinMarketCap
  module Resources
    class Cryptocurrency < Resource
      property 'id'
      property 'name'
      property 'symbol'
      property 'slug'
      property 'is_active'
      property 'status'
      property 'first_historical_data'
      property 'last_historical_data'
      property 'platform', with: ->(v) { Platform.new(v) }
    end
  end
end
