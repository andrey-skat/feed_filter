require 'rss'
require 'open-uri'

class FeedFilter

  class << self
    attr_reader :feeds

    def call(env)
      new(env).response
    end

    def configure(&block)
      @feeds ||= []
      instance_eval(&block)
    end

    #adding filter
    def feed(url, &block)
      @feeds << {
          url: url,
          filter: block
      }
      #unless @feeds.find_index { |item| item.url == url  }
    end
  end

  def initialize(env)
    @feeds = FeedFilter::feeds
    @params = Rack::Request.new(env).params
  end

  def response
    xml = process(@params['url'])
    [
        200,
        { 'Content-Type' => "#{@content_type}; charset=utf-8" },
        [ xml ]
    ]
  end

  def process(url)
    index = @feeds.index { |item| item[:url] == url }
    if index
      feed = download @feeds[index][:url]
      filter(feed, &@feeds[index][:filter]).to_s
    else
      'feed not found'
    end
  end

  private

  def download(url)
    open(url) do |rss|
      feed = RSS::Parser.parse(rss, false, false)
      @content_type = rss.content_type
      return feed
    end
  end

  def filter(feed, &block)
    feed.items.select!(&block)
    feed
  end

end