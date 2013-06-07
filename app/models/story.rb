class Story < ActiveRecord::Base


  has_many :comments
  belongs_to :user
  attr_accessible :title, :url, :text, :created_at
  validates_presence_of :title 
  validates_presence_of :url unless :text
  validates_presence_of :text unless :url
  acts_as_voteable

  after_create :enqueue_create_or_update_document_job
  after_destroy :enqueue_delete_document_job

  def increase_score
    self.score += 1
    save
  end

  def decrease_score
    self.score -= 1
    save
  end

  def calculate_total
    time_in_seconds = Time.now - self.created_at
    time_in_hours = time_in_seconds/3600
    self.total =  (self.score/((time_in_hours +2) ** 1.8))
    self.total
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

  
  private

  def enqueue_create_or_update_document_job
    Delayed::Job.enqueue CreateOrUpdateSwiftypeDocumentJob.new(self.id)
  end

  def enqueue_delete_document_job
    Delayed::Job.enqueue DeleteSwiftypeDocumentJob.new(self.id)
  end

end
