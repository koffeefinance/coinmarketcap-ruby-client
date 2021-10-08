require 'test_helper'

module CoinMarketCap
  module Endpoints
    module Cryptocurrency
      class ListingsTest < Minitest::Test
        def setup
          @client = CoinMarketCap::Api::Client.new
        end

        def test_listings_latest_response_parsed_as_listings_object
          VCR.use_cassette('listings/latest') do
            listings = @client.listings_latest
            assert_equal 100, listings.length

            listing = listings.first
            assert_equal 1, listing.id
            assert_equal 'Bitcoin', listing.name
            assert_equal 'BTC', listing.symbol
            assert_equal 'bitcoin', listing.slug
            assert_equal 8527, listing.num_market_pairs
            assert_equal to_iso8601_date('2013-04-28T00:00:00.000Z'), listing.date_added
            assert_equal %w[
              mineable pow sha-256 store-of-value state-channels coinbase-ventures-portfolio three-arrows-capital-portfolio polychain-capital-portfolio binance-labs-portfolio arrington-xrp-capital blockchain-capital-portfolio boostvc-portfolio cms-holdings-portfolio dcg-portfolio dragonfly-capital-portfolio electric-capital-portfolio fabric-ventures-portfolio framework-ventures galaxy-digital-portfolio huobi-capital alameda-research-portfolio a16z-portfolio 1confirmation-portfolio winklevoss-capital usv-portfolio placeholder-ventures-portfolio pantera-capital-portfolio multicoin-capital-portfolio paradigm-xzy-screener
            ], listing.tags
            assert_equal 21_000_000, listing.max_supply
            assert_equal 18_837_706, listing.circulating_supply
            assert_equal 18_837_706, listing.total_supply
            assert_nil listing.platform
            assert_equal 1, listing.cmc_rank
            assert_equal to_iso8601_date('2021-10-08T03:38:02.000Z'), listing.last_updated
          end
        end

        def test_listings_latest_response_parses_quote
          VCR.use_cassette('listings/latest') do
            listing = @client.listings_latest.first
            quote_in_usd = listing.quote['USD']

            assert_equal 53_853.84605722145, quote_in_usd.price
            assert_equal 35_664_606_394.86121, quote_in_usd.volume_24h
            assert_equal -0.08049597, quote_in_usd.percent_change_1h
            assert_equal -1.93058, quote_in_usd.percent_change_24h
            assert_equal 23.57830268, quote_in_usd.percent_change_7d
            assert_equal 15.8506565, quote_in_usd.percent_change_30d
            assert_equal 24.08594399, quote_in_usd.percent_change_60d
            assert_equal 59.25745607, quote_in_usd.percent_change_90d
            assert_equal 1_014_482_918_995.1969, quote_in_usd.market_cap
            assert_equal 44.5955, quote_in_usd.market_cap_dominance
            assert_equal 1_130_930_767_201.65, quote_in_usd.fully_diluted_market_cap
            assert_equal to_iso8601_date('2021-10-08T03:38:02.000Z'), quote_in_usd.last_updated
          end
        end
      end
    end
  end
end
