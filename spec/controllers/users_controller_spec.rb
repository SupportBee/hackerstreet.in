require 'spec_helper'

describe UsersController do
  render_views
  
 

  describe "PUT 'update'" do
      
    before :each do
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
    end

    describe "failure" do
      
      before :each do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end
      
      it "should render the 'update' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('update')
      end
    end

    describe "success" do
      
      before :each do
        @attr = { :name => "New Name", :email => "user@example.org",
                  :password => "barbaz", :password_confirmation => "barbaz" }
      end
      
      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should  == @attr[:name]
        @user.email.should == @attr[:email]
        @user.encrypted_password.should == assigns(:user).encrypted_password
      end
      
      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "DELETE 'destroy'" do
    
    before :each do
      @user = FactoryGirl.create :user
    end
    
    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @user.id
        response.should redirect_to(users_path)
      end
    end
    
    describe "as non-admin user" do
      it "should protect the action" do
        test_sign_in(@user)
        delete :destroy, :id => @user.id
        response.should redirect_to(users_path)
      end
    end
    
    describe "as an admin user" do
      
      before :each do
        @admin = FactoryGirl.create :user, :email => "admin@example.com", :admin => true
        test_sign_in(@admin)
      end
      
      it "should be able to destroy itself" do
        lambda do
          delete :destroy, :id => @admin
        end.should change(User, :count)
      end
    end
  end
end
