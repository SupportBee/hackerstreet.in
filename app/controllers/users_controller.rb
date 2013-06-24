class UsersController < ApplicationController
  
  def index
    @users = User.find(:all, :order => 'karma DESC').paginate(:per_page => 10, :page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    if user_signed_in? && current_user.role == "admin"
      render 'update'
    end
  end
  
  def edit
    @user = User.new(params[:user])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile updated." }
    else
      render 'update'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to @user
  end

 def comments
   @comments = Comment.find(:all, :order => 'comments.created_at DESC', :conditions => {:user_id => params[:id]}).paginate(:per_page => 10, :page => params[:page])
 end

 def stories
   @stories = Story.find(:all, :order => 'stories.created_at DESC', :conditions => {:user_id => params[:id]}).paginate(:per_page => 10, :page => params[:page])
 end


end
