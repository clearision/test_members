class UrlShortener
  attr_reader :url

  def initialize url
    @url = url
  end

  def shorten
    Rails::Html::FullSanitizer.new.sanitize call_shortener
  end

  private

    def call_shortener
      escaped_url = URI("https://shorturl-sfy-cx.p.rapidapi.com/?url=#{CGI.escape(url)}")
      http = Net::HTTP.new(escaped_url.host, escaped_url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(escaped_url)
      request["x-rapidapi-host"] = 'shorturl-sfy-cx.p.rapidapi.com'
      request["x-rapidapi-key"] = '794965eaefmsh6b5af79f262b73ap1d1217jsnc34e2073a92d'
      response = http.request(request)
      response.read_body
    end
end
