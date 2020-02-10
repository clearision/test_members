class ArticlesSearch
  def initialize member, query
    @member = member
    @query = query
  end

  def search
    relevant_members.map do |rm|
      {
        path: search_friends_path(rm),
        heading: rm[:heading]
      }
    end
  end

  private

    attr_reader :member, :query

    def relevant_members
      member.decorate.possible_friends.map do |friend|
        match = friend.headings.grep(/#{query}/i)
        match.any? ? { member: friend, heading: match } : nil
      end.compact
    end

    def search_friends_path relevant_member
      search_among_friends(relevant_member[:member], member, [member]).map do |member|
        { id: member.id, name: member.name }
      end
    end

    def search_among_friends subject, member, visited
      member.decorate.friends.each do |friend|
        next if visited.include? friend

        return [*visited, subject] if subject.id == friend.id

        result = search_among_friends subject, friend, [*visited, friend]
        return result unless result.blank?
      end

      []
    end
end
