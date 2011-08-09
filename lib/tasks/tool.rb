require 'nokogiri'
require 'open-uri'

module Tool
  def open_html url
    puts "start crawl:  #{url}"
    doc = nil
    tries = 1
    begin
      tries += 1
      doc = Nokogiri::HTML(open(url))
    rescue Exception => ex
      puts ex.inspect

#      if tries < 5
#        sleep 2**tries
#        retry
#      end
    ensure
      doc
    end
  end
end