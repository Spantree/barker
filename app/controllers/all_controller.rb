class AllController < ApplicationController
  layout nil

  def destroy
    Tweet.delete_all
    Relationship.delete_all
    User.delete_all
    render :text => "Application reset!"
  end
end