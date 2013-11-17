require 'spec_helper'

describe WelcomeController do
  render_views

  describe "GET 'index'" do

    describe "when not signed in" do

      before(:each) do
        get :index
      end

      it "returns http success" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector("title", :content => "Twitter Client")
      end
    end

    describe "when signed in" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end

      it "should have the right follower/following counts" do
        get :index
        response.should have_selector("a", :href => following_user_path(@user),
                                           :content => "0 following")
        response.should have_selector("a", :href => followers_user_path(@user),
                                           :content => "1 follower")
      end
    end
  end
end
