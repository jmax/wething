class UserFavoritesController < ApplicationController
  before_filter :authenticate_user!

  def show; end

  def new
    if current_user.favorited_things.include?(current_thing)
      redirect_to root_path, :notice => "The thing is already a favorite."
    else
      current_user.favorite(current_thing)
      redirect_to root_path, :notice => "The thing was added to favorites."
    end
  end

protected
  def favorited_things
    @favorited_things ||= current_user.favorited_things
  end
  helper_method :favorited_things
end
