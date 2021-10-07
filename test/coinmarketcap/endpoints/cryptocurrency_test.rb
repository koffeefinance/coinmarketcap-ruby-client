require 'test_helper'

module CoinMarketCap
  module Endpoints
    class CryptocurrencyTest < Minitest::Test
      def setup
        @client = CoinMarketCap::Api::Client.new
      end

      def test_map_retrieves_a_list_cryptocurrencies
        VCR.use_cassette('map/latest_cryptocurrencies') do
          map = @client.map
          assert !map.nil?
          assert_equal 6974, map.length
        end
      end

      def test_map_response_parsed_as_cyrptocurrency_object
        VCR.use_cassette('map/eth') do
          map = @client.map(symbol: 'ETH')
          assert_equal 1, map.length

          eth = map.first
          assert_equal 1027, eth.id
          assert_equal 'Ethereum', eth.name
          assert_equal 'ETH', eth.symbol
          assert_equal 2, eth.rank
          assert_equal 'ethereum', eth.slug
          assert_equal 1, eth.is_active
          assert_nil eth.status
          assert_equal to_iso8601_date('2015-08-07T14:49:30.000Z'), eth.first_historical_data
          assert_equal to_iso8601_date('2021-10-05T02:19:02.000Z'), eth.last_historical_data
          assert_nil eth.platform
        end
      end

      def test_map_response_parses_platform
        VCR.use_cassette('map/usdt') do
          map = @client.map(symbol: 'USDT')
          assert_equal 1, map.length

          first = map.first
          platform = first.platform
          assert_equal 1027, platform.id
          assert_equal 'Ethereum', platform.name
          assert_equal 'ETH', platform.symbol
          assert_equal 'ethereum', platform.slug
          assert_equal '0xdac17f958d2ee523a2206206994597c13d831ec7', platform.token_address
        end
      end

      def test_info_response_parsed_as_metadata_object
        VCR.use_cassette('info/ethereum') do
          info = @client.info(symbol: 'ETH')
          assert_equal 1, info.size

          ethereum_metadata = info['ETH']
          assert_equal 1027, ethereum_metadata.id
          assert_equal 'Ethereum', ethereum_metadata.name
          assert_equal 'ETH', ethereum_metadata.symbol
          assert_equal 'coin', ethereum_metadata.category
          assert_equal 'Ethereum (ETH) is a cryptocurrency . Users are able to generate ETH '\
                       'through the process of mining. Ethereum has a current supply of '\
                       '117,822,787.3115. The last known price of Ethereum is 3,513.34713647 '\
                       'USD and is up 0.57 over the last 24 hours. It is currently trading '\
                       'on 5010 active market(s) with $22,051,476,761.65 traded over the '\
                       'last 24 hours. More information can be found at https://www.ethereum.org/.',
                       ethereum_metadata.description
          assert_equal 'ethereum', ethereum_metadata.slug
          assert_equal 'https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png', ethereum_metadata.logo
          assert_equal '', ethereum_metadata.notice
          assert_equal %w[
            mineable
            pow
            smart-contracts
            ethereum
            binance-smart-chain
            coinbase-ventures-portfolio
            three-arrows-capital-portfolio
            polychain-capital-portfolio
            binance-labs-portfolio
            arrington-xrp-capital
            blockchain-capital-portfolio
            boostvc-portfolio
            cms-holdings-portfolio
            dcg-portfolio
            dragonfly-capital-portfolio
            electric-capital-portfolio
            fabric-ventures-portfolio
            framework-ventures
            hashkey-capital-portfolio
            kinetic-capital
            huobi-capital
            alameda-research-portfolio
            a16z-portfolio
            1confirmation-portfolio
            winklevoss-capital
            usv-portfolio
            placeholder-ventures-portfolio
            pantera-capital-portfolio
            multicoin-capital-portfolio
            paradigm-xzy-screener
          ], ethereum_metadata.tags
        end
      end

      def test_info_response_parses_platform
        VCR.use_cassette('info/usdt') do
          info = @client.info(symbol: 'USDT')
          ethereum_metadata = info['USDT']

          platform = ethereum_metadata.platform
          assert_equal 1027, platform.id
          assert_equal 'Ethereum', platform.name
          assert_equal 'ETH', platform.symbol
          assert_equal 'ethereum', platform.slug
          assert_equal '0xdac17f958d2ee523a2206206994597c13d831ec7', platform.token_address
        end
      end

      def test_info_response_parses_urls
        VCR.use_cassette('info/ethereum') do
          info = @client.info(symbol: 'ETH')

          ethereum_metadata = info['ETH']
          urls = ethereum_metadata.urls

          assert_equal ['https://www.ethereum.org/',
                        'https://en.wikipedia.org/wiki/Ethereum'], urls.website
          assert_equal ['https://twitter.com/ethereum'], urls.twitter
          assert_equal ['https://forum.ethereum.org/', 'https://ethresear.ch/'], urls.message_board
          assert_equal ['https://gitter.im/orgs/ethereum/rooms'], urls.chat
          assert_equal [
            'https://etherscan.io/',
            'https://ethplorer.io/',
            'https://blockchair.com/ethereum',
            'https://bscscan.com/token/0x2170ed0880ac9a755fd29b2688956bd959f933f8',
            'https://eth.tokenview.com/en/blocklist'
          ], urls.explorer
          assert_equal ['https://reddit.com/r/ethereum'], urls.reddit
          assert_equal ['https://github.com/ethereum/wiki/wiki/White-Paper'], urls.technical_doc
          assert_equal ['https://github.com/ethereum'], urls.source_code
          assert_equal ['https://bitcointalk.org/index.php?topic=428589.0'], urls.announcement
        end
      end
    end
  end
end
