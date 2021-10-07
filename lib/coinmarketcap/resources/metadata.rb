module CoinMarketCap
  module Resources
    class Metadata < Resource
      property 'id'
      property 'name'
      property 'symbol'
      property 'category'
      property 'slug'
      property 'logo'
      property 'description'
      property 'date_added', transform_with: ->(v) { iso8601_date(v) }
      property 'notice'
      property 'tags'
      property 'platform', transform_with: lambda { |v|
        CoinMarketCap::Resources::Platform.new(v) unless v.nil?
      }
      property 'urls', transform_with: lambda { |v|
        CoinMarketCap::Resources::URL.new(v) unless v.nil?
      }
    end
  end
end
