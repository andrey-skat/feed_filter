
FeedFilter.configure do

  feed 'http://feed.rutracker.org/atom/f/2093.atom' do |item|

    m = /\[([0-9]*\.[0-9]*) gb\]/i.match(item.title.to_s)
    if !m.nil? && !m.captures[0].nil?
      m.captures[0].to_f >= 2 && (item.title.to_s =~ /avc/i || item.title.to_s =~ /h\.264/i)
    else
      false
    end

  end

end