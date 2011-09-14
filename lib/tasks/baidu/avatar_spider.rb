require File.expand_path("../../tool.rb", __FILE__)

module BaiDu

  class AvatarSpider

    include Tool

    ROOT = "http://app.fld35.com"
    AJAX_URL = "http://app.fld35.com/fldfzltxapp/AjaxSave.asp?Talk=ReadsBiaoQingCrt&types=113&call="

    GIRL_URL = "http://gexingtouxiang.duapp.com/uploads/nvsheng"
    BOY_URL = "http://gexingtouxiang.duapp.com/uploads/nansheng"
    OTHER_URLS = ["http://gexingtouxiang.duapp.com/uploads/katong", "http://gexingtouxiang.duapp.com/uploads/feizhuliu",
                  "http://gexingtouxiang.duapp.com/uploads/keai", "http://gexingtouxiang.duapp.com/uploads/qinglv"
    ]

    attr_accessor :doc

    def crawl_avatar
      (1..1000).each do |page|
        sleep 5
        @doc = open_html("#{AJAX_URL}#{page}")
        next if @doc.nil?
        @doc.css(".picbox .picbg .picimg img").each do |img|
          url = "#{ROOT}#{img['src']}"
          puts url
          next if Avatar.find_by_url(url)
          Avatar.create(:url => url, :category => Avatar::OTHER)
        end
      end
    end

    def crawl_girl_avatar
      (1..1000).each do |num|
        url = "#{GIRL_URL}/#{num}.jpg"
        begin
          open(url)
        rescue Exception => e
          puts e
          next
        end
        puts url
        Avatar.create(:url => url, :category => Avatar::FEMALE)
      end
    end

    def crawl_boy_avatar
      (1..1000).each do |num|
        url = "#{BOY_URL}/#{num}.jpg"
        begin
          open(url)
        rescue Exception => e
          puts e
          next
        end
        puts url
        Avatar.create(:url => url, :category => Avatar::MALE)
      end
    end

    def crawl_other_avatar
      OTHER_URLS.each do |other_url|
        (1..1000).each do |num|
          url = "#{other_url}/#{num}.jpg"
          begin
            open(url)
          rescue Exception => e
            puts e
            next
          end
          puts url
          Avatar.create(:url => url, :category => Avatar::OTHER)
        end
      end
    end

  end

end