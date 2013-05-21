require 'rubygems'
require 'bundler/setup'

require 'rack'

require './lib/feed_filter'
require './rules.rb'

#use Rack::Reloader
run FeedFilter