# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "crawlable_js/version"

Gem::Specification.new do |s|
  s.name        = "crawlable_js"
  s.version     = CrawlableJS::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Roman Lupiychuk"]
  s.email       = ["roman@slatestudio.com"]
  s.homepage    = "https://github.com/slate-studio/crawlable-js"
  s.summary     = "Make your one page js app indexable"

  s.files = %w(README.md LICENSE) + Dir["lib/**/*", "app/**/*"]
  s.license = 'MIT'

  s.require_paths = ["lib"]

  s.add_dependency "railties",  [">= 3.1"]
  s.add_dependency "sprockets-rails"

  s.add_development_dependency "uglifier"
end
