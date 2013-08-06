module CrawlableJS
  autoload :PhantomjsAPI,  'crawlable_js/phantomjs'
  autoload :Version,       'crawlable_js/version'
  autoload :Configuration, 'crawlable_js/configuration'
  autoload :Rack,          'crawlable_js/rack'
end

require 'crawlable_js/engine'
