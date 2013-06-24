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
    user_id = self.user_id
    user = User.find(user_id)
    user.increase_karma
    save
  end

  def decrease_score
    self.score -= 1
    user_id = self.user_id
    user = User.find(user_id)
    user.decrease_karma
    save
  end

  def kill_story
    self.kill_action = (self.kill_action == "kill")? "un-kill" : "kill"
    self.dead = (self.kill_action == "kill")? "false" : "true"
    self.save
  end

  def blast_story
    self.blast_action = (self.blast_action == "blast")? "un-blast" : "blast"
    self.kill_action = (self.blast_action == "blast")? "kill" : "un-kill"
    self.dead = (self.kill_action == "kill")? "false" : "true"
    self.save
  end

end
