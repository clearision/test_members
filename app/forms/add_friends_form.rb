class AddFriendsForm
  def initialize model, friend_ids
    @model = model
    @friend_ids = friend_ids
  end

  def save
    ActiveRecord::Base.transaction do
      friends.each do |friend|
        next if Friendship.where(member: friend, friend: model).exists?

        Friendship.create! member: model, friend: friend
      end
    end
  end

  private

    attr_reader :model, :friend_ids

    def friends
      @friends ||= Member.find friend_ids
    end
end
