# CrawlableJS

This gem will make your one page application indexable by search engines.

## Usage

Add the gem into your Gemfile

    gem 'crawlable_js', github: 'slate-studio/crawlable-js'

Then, put this into your initializers:

    Rails.configuration.middleware.use "CrawlableJS::Rack"

This gem also support following options:

    CrawlableJS::Configuration.configure do |config|
      config.phantomjs_path   = '/path/to/your/phantomjs'
      config.timeout          = 10
      config.cache_expires_in = 10.hours
      config.is_ready_test    = "document.getElementById('loading') == null"
      config.http_auth_user   = 'user'
      config.http_auth_path   = 'password'
    end

Then, in your layout `application.html.erb` file, add directive which will inform google that all your pages are ajax-generated:

    <meta name="fragment" content="!">

In your config application.rb, turn on multithreading support:

    config.threadsafe!

## License

MIT License. Copyright 2013 Slate Studio

## Authors & contributors

* Roman Lupiychuk <roman@slatestudio.com>
