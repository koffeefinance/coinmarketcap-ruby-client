require 'test_helper'

module CoinMarketCap
  module Endpoints
    module Cryptocurrency
      class QuotesTest < Minitest::Test
        def setup
          @client = CoinMarketCap::Api::Client.new
        end

        def test_quotes_latest_response_parsed_as_listings_object
          VCR.use_cassette('quotes/latest') do
            listings = @client.quotes_latest(symbol: 'BTC')

            listing = listings['BTC']
            assert_equal 1, listing.id
            assert_equal 'Bitcoin', listing.name
            assert_equal 'BTC', listing.symbol
            assert_equal 'bitcoin', listing.slug
            assert_equal 1, listing.is_active
            assert_equal 0, listing.is_fiat
            assert_equal 8439, listing.num_market_pairs
            assert_equal to_iso8601_date('2013-04-28T00:00:00.000Z'), listing.date_added
            assert_equal %w[
              mineable pow sha-256 store-of-value state-channels coinbase-ventures-portfolio three-arrows-capital-portfolio polychain-capital-portfolio binance-labs-portfolio arrington-xrp-capital blockchain-capital-portfolio boostvc-portfolio cms-holdings-portfolio dcg-portfolio dragonfly-capital-portfolio electric-capital-portfolio fabric-ventures-portfolio framework-ventures galaxy-digital-portfolio huobi-capital alameda-research-portfolio a16z-portfolio 1confirmation-portfolio winklevoss-capital usv-portfolio placeholder-ventures-portfolio pantera-capital-portfolio multicoin-capital-portfolio paradigm-xzy-screener
            ], listing.tags
            assert_equal 21_000_000, listing.max_supply
            assert_equal 18_839_937, listing.circulating_supply
            assert_equal 18_839_937, listing.total_supply
            assert_nil listing.platform
            assert_equal 1, listing.cmc_rank
            assert_equal to_iso8601_date('2021-10-10T15:42:02.000Z'), listing.last_updated
          end
        end

        def test_quotes_latest_response_parses_quote
          VCR.use_cassette('quotes/latest') do
            listings = @client.quotes_latest(symbol: 'BTC')
            listing = listings['BTC']
            quote_in_usd = listing.quote['USD']

            assert_equal 55_258.50096464278, quote_in_usd.price
            assert_equal 35_452_113_494.92135, quote_in_usd.volume_24h
            assert_equal 0.16209148, quote_in_usd.percent_change_1h
            assert_equal 0.37808878, quote_in_usd.percent_change_24h
            assert_equal 15.47248778, quote_in_usd.percent_change_7d
            assert_equal 21.6571156, quote_in_usd.percent_change_30d
            assert_equal 18.48522689, quote_in_usd.percent_change_60d
            assert_equal 65.30250933, quote_in_usd.percent_change_90d
            assert_equal 1_041_066_676_888.3092, quote_in_usd.market_cap
            assert_equal 44.9937, quote_in_usd.market_cap_dominance
            assert_equal 1_160_428_520_257.5, quote_in_usd.fully_diluted_market_cap
            assert_equal to_iso8601_date('2021-10-10T15:42:02.000Z'), quote_in_usd.last_updated
          end
        end
      end
    end
  end
end
