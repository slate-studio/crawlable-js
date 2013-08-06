module CrawlableJS
  autoload :Phantomjs, 'crawlable_js/phantomjs'
  autoload :Rack,      'crawlable_js/rack'
  autoload :Config,    'crawlable_js/configuration'
  autoload :Version,   'crawlable_js/version'
end

require 'crawlable_js/engine'
