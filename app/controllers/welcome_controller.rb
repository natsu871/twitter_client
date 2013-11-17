class WelcomeController < ApplicationController
  def index
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.all
    end
  end
end
