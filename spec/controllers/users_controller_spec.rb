require 'spec_helper'

describe UsersController do
  render_views
  

  describe "GET 'new'" do
  
    it "should be successful" do
      get :new
      response.should be_success
    end
  end
  
  describe "POST 'create'" do

    describe "failure" do
      
      before :each do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
    end

    describe "success" do

      before :each do
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end
  
  describe "GET 'edit'" do
    
    before :each do
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
  end

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
      
      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
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

  describe "authentication of edit/update actions" do
    
    before :each do
      @user = FactoryGirl.create(:user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    
      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end

    describe "for signed-in users" do
      
      before :each do
        wrong_user = FactoryGirl.create :user, :email => "user@example.net"
        test_sign_in(wrong_user)
      end
      
      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end
      
      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
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
        response.should redirect_to(signin_path)
      end
    end
    
    describe "as non-admin user" do
      it "should protect the action" do
        test_sign_in(@user)
        delete :destroy, :id => @user.id
        response.should redirect_to(root_path)
      end
    end
    
    describe "as an admin user" do
      
      before :each do
        @admin = FactoryGirl.create :user, :email => "admin@example.com", :admin => true
        test_sign_in(@admin)
      end
      
      it "should not be able to destroy itself" do
        lambda do
          delete :destroy, :id => @admin
        end.should_not change(User, :count)
      end
    end
  end
end
