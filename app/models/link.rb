class Link < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :url, :presence => true

  def self.ordered_by_votes
    joins('left outer join votes on links.id = votes.link_id')
      .group('links.id, links.url, links.title, links.description, links.user_id, links.created_at, links.updated_at')
      .order('sum(coalesce(votes.score, 0)) desc')
  end

  def vote_total
    # TODO: This may do better as a cached field on the link model
    Vote.where(:link_id => self.id).sum('score')
  end
end
