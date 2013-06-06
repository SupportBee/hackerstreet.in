class Comment < ActiveRecord::Base

  has_ancestry
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :story
  belongs_to :comment, :foreign_key => "comment_id"
  has_many :comments, as: :commentable
  attr_accessible :body
  acts_as_voteable

  validates_presence_of :body

  validates :body, :presence => true

  def increase_score
    self.score += 1
    save
  end

  def decrease_score
    self.score -= 1
    save
  end

end
