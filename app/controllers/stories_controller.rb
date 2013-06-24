class StoriesController < ApplicationController
  respond_to :html, :json
  load_and_authorize_resource

  before_filter :authenticate_user!, :except => [:index, :show, :newest, :calender]

  def index
    @stories = Story.order('total DESC').paginate(:per_page => 10, :page => params[:page])
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
    user_story = params[:story]
    if !(user_story[:text].empty? || user_story[:url].empty?)
      redirect_to :back, :flash => { :error => 'Cannot provide both text and url.' }
    else
      if @story.save
        redirect_to @story, :flash => { :success => "Story was successfully created." }
      else
        redirect_to :back, :flash => { :error => 'Story was not created' }
      end
    end
  end

  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(params[:story])
      redirect_to @story, :flash => { :success => 'Story was successfully updated.' }
    else
      redirect_to @story, :flash => { :error => 'Story was not updated' }
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
        redirect_to :back, :flash => { :success => "Story has been upvoted, vote count is #{@story.votes_for}" }
      end

    rescue ActiveRecord::RecordInvalid => e
      redirect_to :back, :flash => { :error => "User has already voted on this story" }
    end

  end

  def downvote

    begin
      @story = Story.find(params[:id])

      if @story.user_id == current_user.id
        redirect_to :back, :flash => { :error => "User cannot vote on his own story" }
      else
        current_user.vote_against(@story)
        @story.decrease_score
        redirect_to :back, :flash => { :success => "Story has been downvoted, vote count is -#{@story.votes_against}" }
      end

    rescue ActiveRecord::RecordInvalid => e
       redirect_to :back, :flash => { :error => "User has already voted on this story" }
    end

  end

  def newest
    @stories = Story.find(:all, :order => 'stories.created_at DESC').paginate(:per_page => 10, :page => params[:page])
  end

  def search
    @stories = Story.search(params[:search]).order().paginate(:per_page => 5, :page => params[:page])
  end

  def calender
    @stories = Story.find(:all, :order => 'total DESC', :limit => '1')
    @date = params[:month] ? Date.parse("#{params[:month]}-01") : Date.today
  end

  def kill
    @story = Story.find(params[:id])
    @story.kill_story
    redirect_to :back
  end

  def blast
    @story = Story.find(params[:id])
    @story.blast_story
    user = @story.user
    user.mark_as_blocked(@story.dead)
    @story.save
    redirect_to :back
  end

  def nuke
    @story = Story.find(params[:id])
    @story.nuke_story
    user = @story.user
    user.mark_as_blocked(@story.dead)
    @story.save
    redirect_to :back
  end

end
