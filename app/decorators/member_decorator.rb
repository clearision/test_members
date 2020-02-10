class MemberDecorator
  def initialize member
    @member = member
  end

  delegate :id, :name, :short_url, to: :member

  def headings
    member.headings.join ", "
  end

  def url
    @url ||= URI.decode member.url
  end

  def friends
    @friends ||= Member.find_by_sql friends_query(member.id)
  end

  def possible_friends
    @possible_friends ||= Member.find_by_sql possible_friends_query(member.id)
  end

  def to_s
    id.to_s
  end

  def to_model
    member
  end

  private

    attr_reader :member

    def friends_query member_id
      <<-SQL
        SELECT members.* FROM members
        WHERE members.id IN (
            SELECT member_id AS id FROM friendships
              WHERE friendships.friend_id = #{member_id}
            UNION
            SELECT friend_id AS id FROM friendships
              WHERE friendships.member_id = #{member_id}
          )
      SQL
    end

    def possible_friends_query member_id
      <<-SQL
        SELECT DISTINCT members.* FROM members
        LEFT OUTER JOIN friendships AS fr
          ON (fr.member_id = members.id OR fr.friend_id = members.id)
          AND (fr.member_id = #{member_id} OR fr.friend_id = #{member_id})
        WHERE fr.id IS NULL AND members.id <> #{member_id}
      SQL
    end
end


