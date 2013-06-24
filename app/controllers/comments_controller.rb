class CommentsController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!, :except => [:index, :show, :newest]

 
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

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to @comment, :flash => { :success => 'Comment was successfully updated.' }
    else
      redirect_to @comment, :flash => { :error => 'Comment was not updated' }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  def kill
    @comment = Comment.find(params[:id])
    @comment.kill_story
    redirect_to :back
  end

  def blast
    @comment = Comment.find(params[:id])
    @comment.blast_story
    user = @comment.user
    user.mark_as_blocked(@comment.dead)
    @comment.save
    redirect_to :back
  end

  def upvote

    begin
      @comment = Comment.find(params[:id])
      
      if @comment.user_id == current_user.id
        redirect_to :back, :flash => { :error => "User cannot vote on his own comment" }
      else
        current_user.vote_for(@comment)
        @comment.increase_score
        redirect_to :back, :flash => { :success => "Comment has been upvoted, vote count is #{@comment.votes_for}" }
      end

    rescue ActiveRecord::RecordInvalid => e
      redirect_to :back, :flash => { :error => "User has already voted on this comment" }
    end

  end

  def downvote

    begin
      @comment = Comment.find(params[:id])

      if @comment.user_id == current_user.id
        redirect_to :back, :flash => { :error => "User cannot vote on his own comment" }
      else
        current_user.vote_against(@comment)
        @comment.decrease_score
        redirect_to :back, :flash => { :success => "Story has been downvoted, vote count is -#{@comment.votes_against}" }
      end

    rescue ActiveRecord::RecordInvalid => e
       redirect_to :back, :flash => { :error => "User has already voted on this comment" }
    end

  end

  def newest
    @comments = Comment.find(:all, :order => 'comments.created_at DESC').paginate(:per_page => 10, :page => params[:page])
  end


end
