module CrawlableJS
  class Engine < ::Rails::Engine
    gem_root = File.expand_path File.dirname(File.dirname(File.dirname(__FILE__)))

    config.crawlable_js = ActiveSupport::OrderedOptions.new
    config.crawlable_js.phantomjs_path   = File.join gem_root, 'bin/phantomjs'
    config.crawlable_js.phantomjs_script = File.join gem_root, 'bin/phantomjs_script.js'
    config.crawlable_js.cache_expires_in = 5.minutes
  end
end
