class Member < ApplicationRecord
  serialize :headings

  has_many :friendships

  validates :name, presence: true, uniqueness: true
  validates :url, :short_url, presence: true

  def decorate
    MemberDecorator.new self
  end
end
