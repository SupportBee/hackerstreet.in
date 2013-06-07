class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :newest]

  def index
    @comments = Comment.find(:all, :order => 'comments.created_at DESC',:conditions => { :user_id => current_user.id }).paginate(:per_page => 10, :page => params[:page])
  end
 
  def show
    @comment = Comment.find(params[:id])
  end

  def create

    if params[:comment_id]
      @parent = Comment.find(params[:comment_id])
    else
      @parent = Story.find(params[:story_id])
    end
    @comment = @parent.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @parent, :flash => { :success => 'Comment was successfully created.' }
    else
      redirect_to @parent, :flash => { :error => 'Comment was not created.' }
    end
  end

  def upvote

    begin
      @comment = Comment.find(params[:id])
      
      if @comment.user_id == current_user.id
        redirect_to :back, :flash => { :error => "User cannot vote on his own comment" }
      else
        current_user.vote_for(@comment)
        @comment.increase_score
        use_id = @story.user_id
        user = User.find(use_id)
        user.increase_karma
        redirect_to :back, :flash => { :success => "Comment has been upvoted, vote count is #{@comment.votes_for}" }
      end

    rescue ActiveRecord::RecordInvalid => e
      redirect_to :back, :flash => { :error => "#{e.message}" }
    end

  end

  def downvote

    begin
      @comment = Comment.find(params[:id])
      authorize! :downvote, @comment

      if @comment.user_id == current_user.id
        redirect_to :back, :flash => { :error => "User cannot vote on his own comment" }
      else
        current_user.vote_against(@comment)
        @comment.decrease_score
        use_id = @story.user_id
        user = User.find(use_id)
        user.decrease_karma
        redirect_to :back, :flash => { :success => "Story has been downvoted, vote count is -#{@comment.votes_against}" }
      end

    rescue ActiveRecord::RecordInvalid => e
       redirect_to :back, :flash => { :error => "#{e.message}" }
    end

  end

  def newest
    @comments = Comment.find(:all, :order => 'comments.created_at DESC').paginate(:per_page => 10, :page => params[:page])
  end


end
