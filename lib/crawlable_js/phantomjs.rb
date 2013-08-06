module CrawlableJS
  class PhantomjsAPI
    def initialize
      @phantomjs_path   = config.phantomjs_path
      @script           = config.phantomjs_script
      @timeout          = (config.timeout || 5) * 1000
      @is_ready_test    = (config.is_ready_test || "true").gsub("'", "\\'").gsub("\n", " ")
      @http_auth_creds  = "#{config.http_auth_user}:#{config.http_auth_pass}" if config.http_auth_user
    end


    def render_url(url)
      shell_command = "#{@phantomjs_path} #{@script} '#{url}' #{@timeout} '#{@is_ready_test}'"
      if @http_auth_creds
        shell_command += " '#{@http_auth_creds}'"
      end

      Rails.logger.info "    rendering page: #{url}"
      Rails.logger.info "    shell command: #{shell_command}"

      start = Time.now
      html_content = `#{shell_command}`
      stop  = Time.now

      Rails.logger.info "    time: #{stop - start}"
      unless $?.success?
        Rails.logger.error "    unsuccess call of phantomjs, exit status: #{$?.exitstatus}"
      end

      html_content
    end


    private

    def config
      ::Rails.configuration.crawlable_js
    end
  end
end