require 'spec_helper'

describe Story do

  before(:each) do
    @user = FactoryGirl.create :user
    @attr = { :title => "lorem ipsum", :url => "www.example.com", :text => "this is a sample text" }
  end
  
  describe "validation of a submission" do

    it "should require nonblank title" do
      @user.stories.build(:title => "    ").should_not be_valid
    end

    it "should require nonblank text if url is blank" do
      @user.stories.build(:text => "    ", url: nil).should_not be_valid
    end

    it "should require nonblank url if text is blank" do
      @user.stories.build(:url => "    ", text: nil).should_not be_valid
    end
  end

end
