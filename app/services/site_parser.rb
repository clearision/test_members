class SiteParser
  attr_reader :url

  def initialize url
    @url = url
  end

  def parse
    body = get_body

    return if body.blank?

    get_headings body
  end

  private

    def get_headings response_body
      parsed_body = Nokogiri::HTML response_body
      parsed_body.search("h1,h2,h3,h4,h5,h6").map { |el| el.text.strip }
    end

    def get_body
      parsed_uri = URI(url)
      http = Net::HTTP.new(parsed_uri.host, parsed_uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(parsed_uri)
      response = http.request(request)

      return unless response.code == '200'

      response.read_body
    end
end
