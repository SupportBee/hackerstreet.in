class StoriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :newest]

  def index
    @stories = Story.find(:all, :order => 'total DESC').paginate(:per_page => 10, :page => params[:page])
  end

  def show
    @story = Story.find(params[:id])
  end

  def new
    @story = Story.new
  end

  def edit
    @story = Story.find(params[:id])
  end

  def create
    @story = Story.new(params[:story])
    @story.user_id = current_user.id
    if @story.save
      redirect_to @story, :flash => { :success => 'Story was successfully created.' }
    else
      redirect_to @story, :flash => { :error => 'Story was not created' }
    end
  end

  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(params[:story])
      redirect_to @story, :flash => { :success => 'Story was successfully updated.' }
    else
      redirect_to @story, :flash => { :error => 'Story was not created' }
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_url
  end

  def upvote

    begin
      @story = Story.find(params[:id])
      
      if @story.user_id == current_user.id
        redirect_to :back, :flash => { :error => "User cannot vote on his own story" }
      else
        current_user.vote_for(@story)
        @story.increase_score
        use_id = @story.user_id
        user = User.find(use_id)
        user.increase_karma
        redirect_to :back, :flash => { :success => "Story has been upvoted, vote count is #{@story.votes_for}" }
      end

    rescue ActiveRecord::RecordInvalid => e
      redirect_to :back, :flash => { :error => "#{e.message}" }
    end

  end

  def downvote

    begin
      @story = Story.find(params[:id])
      authorize! :downvote, @story

      if @story.user_id == current_user.id
        redirect_to :back, :flash => { :error => "User cannot vote on his own story" }
      else
        current_user.vote_against(@story)
        @story.decrease_score
        use_id = @story.user_id
        user = User.find(use_id)
        user.decrease_karma
        redirect_to :back, :flash => { :success => "Story has been downvoted, vote count is -#{@story.votes_against}" }
      end

    rescue ActiveRecord::RecordInvalid => e
       redirect_to :back, :flash => { :error => "#{e.message}" }
    end

  end

  def newest
    @stories = Story.find(:all, :order => 'stories.created_at DESC').paginate(:per_page => 10, :page => params[:page])
  end

  def user_stories
    @stories = Story.find(:all, :order => 'stories.created_at DESC', :conditions => { :user_id => current_user.id }).paginate(:per_page => 10, :page => params[:page])
  end

  def search
    @stories = Story.search(params[:search]).order().paginate(:per_page => 5, :page => params[:page])
  end

end
