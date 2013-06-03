require 'spec_helper'

describe Story do

  before(:each) do
    @user = FactoryGirl.create :user
    @attr = { :title => "lorem ipsum", :url => "www.example.com" }
  end
  
  it "should create a new instance with valid attributes" do
    @user.stories.create!(@attr)
  end
  
  describe "user associations" do
    
    before :each do
      @story = @user.stories.create(@attr)
    end
    
    it "should have a user attribute" do
      @story.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @story.user_id.should == @user.id
      @story.user.should == @user
    end
  end
  
  describe "validations" do

    it "should have a user id" do
      Story.new(@attr).should be_valid
    end

    it "should require nonblank title" do
      @user.stories.build(:title => "    ").should_not be_valid
    end

    it "should require nonblank url" do
      @user.stories.build(:url => "    ").should_not be_valid
    end
  end

end
