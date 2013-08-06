module CrawlableJS
  class Configuration
    def self.configure
      yield ::Rails.configuration.crawlable_js
    end
  end
end
