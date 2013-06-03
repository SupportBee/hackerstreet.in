require 'spec_helper'

describe Comment do

  before(:each) do
    @user = FactoryGirl.create :user
    @attr = { :body => "lorem ipsum" }
  end
  
  it "should create a new instance with valid attributes" do
    @user.comments.create!(@attr)
  end
  
  describe "user associations" do
    
    before :each do
      @comment = @user.comments.create(@attr)
    end
    
    it "should have a user attribute" do
      @comment.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @comment.user_id.should == @user.id
      @comment.user.should == @user
    end
  end
  
  describe "validations" do

    it "should have a user id" do
      Comment.new(@attr).should be_valid
    end

    it "should require nonblank body" do
      @user.comments.build(:body => "    ").should_not be_valid
    end
  end

end
