# CoinMarketCap Ruby API Client

[![Gem Version](https://badge.fury.io/rb/coinmarketcap-ruby-client.svg)](https://badge.fury.io/rb/coinmarketcap-ruby-client) ![Build Status](https://github.com/koffeefinance/coinmarketcap-ruby-client/actions/workflows/ruby.yml/badge.svg)


A ruby API client for [CoinMarketCap](https://coinmarketcap.com/api/documentation/v1/)

# Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Get an API Key](#get-an-api-token)
  - [Configure](#configure)
  - [Get CoinMarketCap ID Map](#get-coinmarketcap-id-map)
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

### Configure

```ruby
CoinMarketCap::Api.configure do |config|
  config.api_key = 'api_key'
  config.user_agent = 'custom/user_agent' # Default: 'CoinMarketCap Ruby Client/1.0.0'
  config.user_agent = 'https://pro-api.coinmarketcap.com/v1' # Default: 'https://pro-api.coinmarketcap.com/v1'
end
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

See [Cryptocurrency Map](https://coinmarketcap.com/api/documentation/v1/#operation/getV1CryptocurrencyMap) for detailed documentation.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[koffeefinance]/coinmarketcap-ruby-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/koffeefinance/coinmarketcap-ruby-client/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CoinMarketCap-Ruby-Client project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/koffeefinance/coinmarketcap-ruby-client/blob/master/CODE_OF_CONDUCT.md).
