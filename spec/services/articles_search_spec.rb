require 'rails_helper'

RSpec.describe ArticlesSearch do
  fixtures :members
  fixtures :friendships

  subject { searcher.search }

  let(:searcher) { described_class.new members(:john), 'music' }

  let(:expected_members) do
    [members(:john), members(:jack), members(:patrick)].map do |member|
      { id: member.id, name: member.name }
    end
  end

  let(:expected_result) do
    [{
      path: expected_members,
      heading: ["Music"]
    }]
  end

  it { is_expected.to eq expected_result }

  context 'for member with both friends' do
    let(:searcher) { described_class.new members(:jack), 'books' }

    it "doesn't include friends in result" do
      is_expected.to eq []
    end
  end
end
