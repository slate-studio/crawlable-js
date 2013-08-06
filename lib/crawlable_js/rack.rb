module CrawlableJS
  class Rack
    def initialize(app, options={})
      @app           = app
      @phantomjs_api = PhantomjsAPI.new
    end

    def call(env)
      @status, @headers, @response = @app.call(env)

      request = ::Rack::Request.new(env)
      if se_request?(request)
        Rails.logger.info ">>> CrawlableJS"

        original_url = original_url(request)
        html_content = Rails.cache.fetch ["crawlablejs", original_url], compress: true, expires_in: config.cache_expires_in do
          @phantomjs_api.render_url(original_url)
        end

        [@status, @headers, [html_content]]
      else
        [@status, @headers, @response]
      end
    end

    private

    def se_request?(request)
      request.get? && request.params.has_key?("_escaped_fragment_") && @headers["Content-Type"].include?("text/html")
    end

    def original_url(request)
      request.url().gsub(/_escaped_fragment_=?[^&]*(?:&|$)/, "")
    end

    def config
      ::Rails.configuration.crawlable_js
    end
  end
end
