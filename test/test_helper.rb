$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'coinmarketcap'
require 'date'

require 'minitest/autorun'
require 'mocha/minitest'

require File.expand_path './support/vcr.rb', __dir__

def to_iso8601_date(timestamp)
  Date.iso8601(timestamp)
end
