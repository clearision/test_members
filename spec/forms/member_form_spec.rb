require 'rails_helper'

RSpec.describe MemberForm do
  let(:member) { Member.new }
  let(:member_name) { 'Peter' }
  let(:params) do
    {
      name: member_name,
      url: 'looong.url'
    }
  end
  let(:form) { described_class.new member, params }

  before do
    allow_any_instance_of(UrlShortener).to receive(:shorten).and_return 'shrt.lnk'
    allow_any_instance_of(SiteParser).to receive(:parse).and_return ['Goose', 'Bumps']
  end

  describe '#valid?' do
    subject { form.valid? }

    before { form.send :assign_attributes }

    it { is_expected.to be_truthy }

    context 'when member is invalid' do
      let(:member_name) { 'John' }

      it { is_expected.to be_falsey }
    end
  end

  describe '#save' do
    subject { form.save }

    context 'creating record' do
      it 'saves the model' do
        expect{ subject }.to change{ form.member.persisted? }.from(false).to true
      end
    end

    context 'updating record' do
      fixtures(:members)

      let(:member) { members(:john) }

      it 'saves the model' do
        expect{ subject }.to change{ form.member.name }.from('John').to 'Peter'
      end
    end
  end
end
