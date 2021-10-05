$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'coinmarketcap'

require 'minitest/autorun'
require 'mocha/minitest'

require File.expand_path './support/vcr.rb', __dir__
