require 'spec_helper'


describe StoriesController do
  render_views 

  describe "access control" do
    include Devise::TestHelpers
    it "should deny access to 'create'" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create
      response.should redirect_to(new_user_session_path)
    end
  end
  
  describe "POST 'create'" do
    
    before :each do
      @user = sign_in User.new
    end

    describe "failure" do

      before :each do
        @attr = { :title => " " , :url => "www.example.com" }
      end

      it "should not create a story" do
        lambda do
          post :create, :story => @attr
        end
      end
    end

    describe "success" do
      
      before :each do
        @attr = { :title => "Lorem ipsum dolor sit amet", :url => "www.example.com", :text => "this is a sample text" }
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
        sign_in wrong_user
      end

      it "should deny access" do
        delete :destroy, :id => @story
        response.should redirect_to("/")
      end
    end
    
    describe "for an authorized user" do
      
      before :each do
        @user = sign_in User.new
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
