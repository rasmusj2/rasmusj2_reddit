class Vote < ActiveRecord::Base
  belongs_to :voter, :class_name => 'User'
  validates :voter_id, :presence => true

  belongs_to :link
  validates :link_id, :presence => true

  # A user may only vote on a link once
  validates_uniqueness_of :link_id, :scope => :voter_id
end
