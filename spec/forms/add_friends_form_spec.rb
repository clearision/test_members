require 'rails_helper'

RSpec.describe AddFriendsForm do
  fixtures(:members)
  fixtures(:friendships)

  let(:member) { members(:john) }
  let(:friend_ids) { [members(:patrick).id] }
  let(:form) { described_class.new member, friend_ids }

  describe '#save' do
    subject { form.save }

    context 'adding new friend' do
      it 'creates the friendship' do
        expect{ subject }.to change{ Friendship.where(member: member, friend: members(:patrick)).exists? }.from(false).to true
      end
    end

    context 'adding existing friend' do
      let(:member) { members(:jack) }
      let(:friend_ids) { [members(:john).id] }

      it "doesn't create the friendship" do
        expect{ subject }.not_to change{ Friendship.where(member: member, friend: members(:john)).exists? }.from(false)
      end
    end
  end
end
