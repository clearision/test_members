require 'rails_helper'

RSpec.describe SiteParser do
  subject { parser.parse }

  let(:parser) { described_class.new 'url' }

  let(:body) do
    <<-FOO
      <html>
        <head></head>
        <body>
          <h1>head 1</h1>
          <h2>head 2</h2>
          <h5>head 5</h5>
        </body>
      </html>
    FOO
  end

  before do
    allow(parser).to receive(:get_body).and_return body
  end

  it 'collects the header tags' do
    is_expected.to eq ['head 1', 'head 2', 'head 5']
  end
end
