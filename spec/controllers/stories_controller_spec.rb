require 'spec_helper'

describe StoriesController do
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

      it "should not create a story" do
        lambda do
          post :create, :story => @attr
        end.should_not change(Story, :count)
      end

      it "should redirect to the stories path" do
        post :create, :story => @attr
        response.should redirect_to(stories_path)
      end
    end

    describe "success" do
      
      before :each do
        @attr = { :title => "Lorem ipsum dolor sit amet", :url => "www.example.com" }
      end
      
      it "should create a story" do
        lambda do
          post :create, :story => @attr
        end
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do
      
      before :each do
        @user = FactoryGirl.create :user
        wrong_user = FactoryGirl.create :user, :email => "wrongemail@example.com"
        @story = FactoryGirl.create :story, :user => @user
        test_sign_in(wrong_user)
      end

      it "should deny access" do
        delete :destroy, :id => @story
        response.should redirect_to(stories_path)
      end
    end
    
    describe "for an authorized user" do
      
      before :each do
        @user = test_sign_in(FactoryGirl.create :user)
        @micropost = FactoryGirl.create :story, :user => @user
      end
      
      it "should destroy the story" do
        lambda do
          delete :destroy, :id => @story
          flash[:success].should =~ /deleted/i
          response.should redirect_to(stories_path)
        end
      end
    end
  end
end
