require 'spec_helper'


describe PagesController do
  render_views


  describe "GET 'contact'" do
    include Devise::TestHelpers
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    include Devise::TestHelpers
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'help'" do
    include Devise::TestHelpers
    it "should be successful" do
      get 'help'
      response.should be_success
    end
  end
end
