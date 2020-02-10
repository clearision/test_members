require 'rails_helper'

RSpec.describe MemberDecorator do
  fixtures :members

  let(:member) { members :john }

  context 'decorated' do
    subject { member.decorate }

    describe '#headings' do
      it 'joins headings with comma' do
        expect(subject.headings).to eq "Books, Cars"
      end
    end

    describe '#url' do
      it 'encodes the original url' do
        expect(subject.url).to eq "http://loong.url"
      end
    end

    describe '#friends' do
      fixtures :friendships

      it 'returns friends list' do
        expect(subject.friends).to eq [members(:jack)]
      end
    end

    describe '#possible_friends' do
      fixtures :friendships

      it 'returns unknown members list' do
        expect(subject.possible_friends).to eq [members(:patrick)]
      end
    end

    describe '#to_s' do
      it 'returns member id' do
        expect(subject.to_s).to eq member.id.to_s
      end
    end

    describe '#to_member' do
      it 'returns member' do
        expect(subject.to_model).to eq member
      end
    end
  end
end
