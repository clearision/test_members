require 'rails_helper'

RSpec.describe UrlShortener do
  subject { url_shortener.shorten }

  let(:url_shortener) { described_class.new 'url' }
  let(:body) { "<a href=\"shrt.lnk\">shrt.lnk</a>" }

  before do
    allow(url_shortener).to receive(:call_shortener).and_return body
  end

  it 'removes the HTML tags' do
    is_expected.to eq 'shrt.lnk'
  end
end
