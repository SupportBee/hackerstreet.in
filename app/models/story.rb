class Story < ActiveRecord::Base

  has_many :comments
  belongs_to :user
  attr_accessible :title, :url, :created_at
  validates_presence_of :title, :url
  validates_uniqueness_of :url
  acts_as_voteable

  def increase_score
    self.score += 1
    calculate_total
    save
  end

  def calculate_total
    time_in_seconds = Time.now - self.created_at
    time_in_hours = time_in_seconds/3600
    self.total =  ((time_in_hours +2) ** 1.8)/self.score
    save
  end

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end


  def url_domain
    URI(url).host
  end
end
