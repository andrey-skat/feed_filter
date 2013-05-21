# feed_filter

Rack app for advanced filtering RSS and Atom feeds. It's work like a proxy, so you can use any news agregator.

## Getting started

```sh
$ git clone git@github.com:andrey-skat/feed_filter.git
```
then run
```sh
$ bundle install
```

## Run

Go to the directory with feed_filter and run
```sh
$ rackup
```

## Configuration
`rules.rb` is a file with feed urls and filters (see example below).

To filter feed, add it url to your feed aggregator like so `http://your-app-domain.com/?url=http://feedurl.com`

## Simple example
in `feed_filter/rules.rb`

```ruby
FeedFilter.configure do

  #filter out only those articles that mention Ruby
  #block gets article object as parameter
  #if block return false, then article would be excluded
  feed 'http://habrahabr.ru/rss/hubs/' do |item|
       item.title.to_s =~ /ruby/i
  end

end
```