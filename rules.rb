
FeedFilter.configure do

  #show only AVC and bigger than 2GB
  feed 'http://feed.rutracker.org/atom/f/2093.atom' do |item|
    filter_movies(item)
  end
  feed 'http://feed.rutracker.org/atom/f/2200.atom' do |item|
    filter_movies(item)
  end

  #filter out only those articles that mention Ruby
  #block gets article object as parameter
  #if block return false, then article would be excluded
  feed 'http://habrahabr.ru/rss/hubs/' do |item|
    item.title.to_s =~ /ruby/i
  end

end

def filter_movies(item)
  m = /\[([0-9]*\.[0-9]*) gb\]/i.match(item.title.to_s)
  if !m.nil? && !m.captures[0].nil?
    m.captures[0].to_f >= 2 && (item.title.to_s =~ /avc/i || item.title.to_s =~ /h\.264/i)
  else
    false
  end
end