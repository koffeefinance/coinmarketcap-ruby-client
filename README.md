# CoinMarketCap Ruby API Client

[![Gem Version](https://badge.fury.io/rb/coinmarketcap-ruby-client.svg)](https://badge.fury.io/rb/coinmarketcap-ruby-client) ![Build Status](https://github.com/koffeefinance/coinmarketcap-ruby-client/actions/workflows/ruby.yml/badge.svg)

A ruby API client for [CoinMarketCap](https://coinmarketcap.com/api/documentation/v1/)

# Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Get an API Key](#get-an-api-token)
  - [Require](#require)
  - [Configure](#configure)
  - [Get CoinMarketCap ID Map](#get-coinmarketcap-id-map)
  - [Get Cryptocurrency Metadata](#get-cryptocurrency-metadata)
  - [Get Latest Listings](#get-latest-listings)
  - [Get Latest Quotes](#get-latest-quotes)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coinmarketcap-ruby-client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install coinmarketcap-ruby-client

## Usage

### Get an API Key

Create an account on [CoinMarketCap](https://pro.coinmarketcap.com/) and get copy the API key from the developer console.

### Require

```ruby
require 'coinmarketcap'
```

### Configure

Set global configurations for the client

```ruby
CoinMarketCap::Api.configure do |config|
  config.api_key = 'api_key'
  config.user_agent = 'custom/user_agent' # Default: 'CoinMarketCap Ruby Client/1.0.0'
  config.endpoint = 'https://pro-api.coinmarketcap.com/v1' # Default: 'https://pro-api.coinmarketcap.com/v1'
end
```

or instantiate a local client

```ruby
client = CoinMarketCap::Api::Client.new(
  api_key: 'api_key',
  user_agent: 'custom/user_agent',
  endpoint: 'https://pro-api.coinmarketcap.com/v1'
)
```

### Get CoinMarketCap ID Map

Fetches the CoinMarketCap ID Map. By default this endpoint returns cryptocurrencies that have actively tracked markets on supported exchanges.

```ruby
cryptocurrencies = client.map

currency = cryptocurrencies.first
currency.id # 825
currency.name # 'Tether'
currency.symbol # 'USDT'
currency.rank # 5
currency.slug # 'tether'
currency.is_active # 1
currency.first_historical_data # <Date: 2015-02-25 ((2457079j,0s,0n),+0s,2299161j)>
currency.last_historical_data # <Date: 2021-10-05 ((2459493j,0s,0n),+0s,2299161j)>

platform = currency.platform
platform.id # 1027
platform.name # 'Ethereum'
platform.symbol # 'ETH'
platform.slug # 'ethereum'
platform.token_address # '0xdac17f958d2ee523a2206206994597c13d831ec7'
```

See [CoinMarketCap ID Map](https://coinmarketcap.com/api/documentation/v1/#operation/getV1CryptocurrencyMap) for detailed documentation.

### Get Cryptocurrency Metadata

Fetches static metadata available for one or more cryptocurrencies.

```ruby
  info = client.info(symbol: 'ETH')

  metadata = info['ETH']
  metadata.id # 1027
  metadata.name # 'Ethereum'
  metadata.symbol # 'ETH'
  metadata.category # 'coin'
  metadata.description # 'Ethereum (ETH) is a cryptocurrency . Users are able to generate ETH ...'
  metadata.slug # 'ethereum'
  metadata.logo # 'https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png'
  metadata.notice # ''
  metadata.tags # ['mineable', 'pow', 'smart-contracts', ...]
  metadata.platform # nil

  urls = metadata.urls
  urls.website # ['https://www.ethereum.org/', 'https://en.wikipedia.org/wiki/Ethereum']
  urls.twitter # ['https://twitter.com/ethereum']
  urls.message_board # ['https://forum.ethereum.org/', 'https://ethresear.ch/']
  urls.chat # ['https://gitter.im/orgs/ethereum/rooms']
  urls.explorer # ['https://etherscan.io/', 'https://ethplorer.io/', 'https://blockchair.com/ethereum', ...]
  urls.reddit # ['https://reddit.com/r/ethereum']
  urls.technical_doc # ['https://github.com/ethereum/wiki/wiki/White-Paper']
  urls.source_code # ['https://github.com/ethereum']
  urls.announcement # ['https://bitcointalk.org/index.php?topic=428589.0']
```

See [Cryptocurrency Metadata](https://coinmarketcap.com/api/documentation/v1/#operation/getV1CryptocurrencyInfo) for detailed documentation.

### Get Latest Listings

Returns a paginated list of all active cryptocurrencies with latest market data.

```ruby
  listings = client.listings_latest
  listing = listings.first

  listing.id # 1
  listing.name # 'Bitcoin'
  listing.symbol # 'BTC'
  listing.slug # 'bitcoin'
  listing.num_market_pairs # 8527
  listing.date_added # <Date: 2013-04-28 ((2456411j,0s,0n),+0s,2299161j)>
  listing.tags # ['mineable', 'pow', 'sha-256', 'store-of-value', ...]
  listing.max_supply # 21000000
  listing.circulating_supply # 18837706
  listing.total_supply # 18837706
  listing.platform # nil
  listing.cmc_rank # 1
  listing.last_updated # <Date: 2021-10-08 ((2459496j,0s,0n),+0s,2299161j)>

  quote_in_usd = listing.quote['USD']

  quote_in_usd.price # 53853.84605722145
  quote_in_usd.volume_24h # 35664606394.86121
  quote_in_usd.percent_change_1h # -0.08049597
  quote_in_usd.percent_change_24h # -1.93058
  quote_in_usd.percent_change_7d # 23.57830268
  quote_in_usd.percent_change_30d # 15.8506565
  quote_in_usd.percent_change_60d # 24.08594399
  quote_in_usd.percent_change_90d # 59.25745607
  quote_in_usd.market_cap # 1014482918995.1969
  quote_in_usd.market_cap_dominance # 44.5955
  quote_in_usd.fully_diluted_market_cap # 1130930767201.65
  quote_in_usd.last_updated # <Date: 2021-10-08 ((2459496j,0s,0n),+0s,2299161j)>
```

See [Listings Latest](https://coinmarketcap.com/api/documentation/v1/#operation/getV1CryptocurrencyListingsLatest) for detailed documentation.

### Get Latest Quotes

Returns the latest market quote for 1 or more cryptocurrencies. Use the "convert" option to return market values in multiple fiat and cryptocurrency conversions in the same call.

```ruby
  listings = client.quotes_latest(symbol: 'BTC')
  listing = listings['BTC']

  listing.id # 1
  listing.name # 'Bitcoin'
  listing.symbol # 'BTC'
  listing.slug # 'bitcoin'
  listing.is_active # 1
  listing.is_fiat # 0
  listing.num_market_pairs # 8527
  listing.date_added # <Date: 2013-04-28 ((2456411j,0s,0n),+0s,2299161j)>
  listing.tags # ['mineable', 'pow', 'sha-256', 'store-of-value', ...]
  listing.max_supply # 21000000
  listing.circulating_supply # 18837706
  listing.total_supply # 18837706
  listing.platform # nil
  listing.cmc_rank # 1
  listing.last_updated # <Date: 2021-10-08 ((2459496j,0s,0n),+0s,2299161j)>

  quote_in_usd = listing.quote['USD']

  quote_in_usd.price # 53853.84605722145
  quote_in_usd.volume_24h # 35664606394.86121
  quote_in_usd.percent_change_1h # -0.08049597
  quote_in_usd.percent_change_24h # -1.93058
  quote_in_usd.percent_change_7d # 23.57830268
  quote_in_usd.percent_change_30d # 15.8506565
  quote_in_usd.percent_change_60d # 24.08594399
  quote_in_usd.percent_change_90d # 59.25745607
  quote_in_usd.market_cap # 1014482918995.1969
  quote_in_usd.market_cap_dominance # 44.5955
  quote_in_usd.fully_diluted_market_cap # 1130930767201.65
  quote_in_usd.last_updated # <Date: 2021-10-08 ((2459496j,0s,0n),+0s,2299161j)>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[koffeefinance]/coinmarketcap-ruby-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/koffeefinance/coinmarketcap-ruby-client/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CoinMarketCap-Ruby-Client project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/koffeefinance/coinmarketcap-ruby-client/blob/master/CODE_OF_CONDUCT.md).
