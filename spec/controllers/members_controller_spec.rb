require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  fixtures :members
  fixtures :friendships

  describe 'GET /members' do
    # subject { ActiveSupport::JSON.decode response.body }

    before do
      get :index
    end

    it 'renders index template' do
      expect(response).to render_template('index')
    end

    it 'fetches members records' do
      expect(assigns[:members].count).to eq members.count
    end

    it 'decorates records' do
      expect(assigns[:members].first).to be_kind_of MemberDecorator
    end
  end

  describe 'GET /members/:id' do
    let(:member) { members(:john) }

    before do
      get :show, params: { id: member.id }
    end

    it 'renders show template' do
      expect(response).to render_template('show')
    end

    it 'fetches member record' do
      expect(assigns[:member].to_model).to eq member
    end

    it 'decorates the record' do
      expect(assigns[:member]).to be_a MemberDecorator
    end
  end

  describe 'GET /members/new' do
    before do
      get :new
    end

    it 'renders new template' do
      expect(response).to render_template('new')
    end

    it 'assigns a model' do
      expect(assigns[:member].class).to eq Member
    end

    it 'assigns an empty model' do
      expect(assigns[:member].new_record?).to be_truthy
    end
  end

  describe 'GET /members/:id/edit' do
    let(:member) { members(:john) }

    before do
      get :edit, params: { id: member.id }
    end

    it 'renders edit template' do
      expect(response).to render_template('edit')
    end

    it 'assigns a model' do
      expect(assigns[:member]).to eq member
    end
  end

  describe 'POST /members' do
    let(:member) { Member.where(name: 'Howard').first }

    before do
      allow_any_instance_of(UrlShortener).to receive(:shorten).and_return 'shrt.lnk'
      allow_any_instance_of(SiteParser).to receive(:parse).and_return ['Goose', 'Bumps']

      post :create, params: { member: { name: 'Howard', url: 'url' } }
    end

    it 'create the record' do
      expect(member.persisted?).to be_truthy
    end

    it 'redirects to show' do
      expect(response).to redirect_to member_path(member)
    end
  end

  describe 'PUT /members/:id' do
    let(:member) { members(:john) }

    before do
      put :update, params: { id: member.id, member: { name: 'Howard' } }
    end

    it 'updates the record' do
      expect(member.reload.name).to eq 'Howard'
    end

    it 'redirects to show' do
      expect(response).to redirect_to member_path(member)
    end
  end

  describe 'DELETE /members/:id' do
    let(:member) { members(:john) }

    before do
      delete :destroy, params: { id: member.id }
    end

    it 'deletes the record' do
      expect(Member.where(name: 'John').exists?).to be_falsey
    end

    it 'redirects to index' do
      expect(response).to redirect_to members_path
    end
  end

  describe 'GET /members/:id/search' do
    let(:member) { members(:john) }
    let(:parsed_body) { JSON.parse(response.body).with_indifferent_access }
    let(:result) { parsed_body[:result] }
    let(:expected_path) do
      [members(:john), members(:jack), members(:patrick)].map do |mem|
        { "id" => mem.id, "name" => mem.name }
      end
    end

    before do
      get :search, format: :json, params: { id: member.id, query: 'music' }
    end

    it 'returns path in response' do
      expect(result[0][:path]).to eq expected_path
    end

    it 'returns matched headings in response' do
      expect(result[0][:heading]).to eq ['Music']
    end
  end

  describe 'POST /members/:id/add_friends' do
    let(:member) { members(:john) }

    before do
      post :add_friends, params: { id: member.id, member: { friends: [members(:patrick).id] } }
    end

    it 'creates friendships (so cute)' do
      expect(Friendship.where(member: member, friend: members(:patrick)).exists?).to be_truthy
    end

    it 'redirects back to member' do
      expect(response).to redirect_to member_path(member)
    end
  end
end
