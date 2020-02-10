require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:member) { described_class.new }

  describe 'validations' do
    subject { member.valid? }

    it { is_expected.to be_falsey }

    context 'when validation fails' do
      subject { member.errors.to_a }

      let(:expected_errors) { ["Name can't be blank", "Url can't be blank", "Short url can't be blank"] }

      before { member.save }

      it 'stores errors for fields' do
        is_expected.to eq expected_errors
      end

      context 'when member with the same name exists' do
        fixtures :members

        let(:expected_error) { "Name has already been taken" }

        before do
          member.name = 'John'
          member.save
        end

        it 'stores uniqueness validation error' do
          is_expected.to include(expected_error)
        end
      end
    end
  end

  describe '#decorate' do
    subject { member.decorate }

    it { is_expected.to be_kind_of MemberDecorator }
  end
end
