require 'spec_helper'

describe CommentsController do
  render_views 

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do
    
    before :each do
      @user = test_sign_in(FactoryGirl.create :user)
    end

    describe "failure" do

      before :each do
        @attr = { :content => "" }
      end

      it "should not create a comment" do
        lambda do
          post :create, :comment => @attr
        end.should_not change(Comment, :count)
      end

      it "should redirect to the comments path" do
        post :create, :comment => @attr
        response.should redirect_to(comments_path)
      end
    end

    describe "success" do
      
      before :each do
        @attr = { :body => "Lorem ipsum dolor sit amet"}
      end
      
      it "should create a comment" do
        lambda do
          post :create, :comment => @attr
        end
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do
      
      before :each do
        @user = FactoryGirl.create :user
        wrong_user = FactoryGirl.create :user, :email => "wrongemail@example.com"
        @story = FactoryGirl.create :comment, :user => @user
        test_sign_in(wrong_user)
      end

      it "should deny access" do
        delete :destroy, :id => @comment
        response.should redirect_to(commentss_path)
      end
    end
    
    describe "for an authorized user" do
      
      before :each do
        @user = test_sign_in(FactoryGirl.create :user)
        @micropost = FactoryGirl.create :comment, :user => @user
      end
      
      it "should destroy the story" do
        lambda do
          delete :destroy, :id => @story
          flash[:success].should =~ /deleted/i
          response.should redirect_to(root_path/stories)
        end
      end
    end
  end
end
