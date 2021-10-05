require 'test_helper'

module CoinMarketCap
  class VersionTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil CoinMarketCap::VERSION
    end
  end
end
