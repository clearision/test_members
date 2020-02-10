class MemberForm
  include ActiveModel

  attr_reader :member, :params

  def initialize member, params
    @member = member
    @params = params
  end

  def save
    assign_attributes
    member.save
  end

  def valid?
    member.valid? && member.short_url.present? && member.headings.present?
  end

  private

    def assign_attributes
      member.assign_attributes prepared_params
    end

    def prepared_params
      params.merge short_url: url_shortener.shorten, headings: site_parser.parse
    end

    def url_shortener
      @url_shortener ||= UrlShortener.new params[:url]
    end

    def site_parser
      @site_parser ||= SiteParser.new params[:url]
    end
end
