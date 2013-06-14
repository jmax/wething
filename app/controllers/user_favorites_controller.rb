class UserFavoritesController < ApplicationController
  before_filter :authenticate_user!

  def show; end

  def new
    notice = "The thing is already a favorite."
    unless current_user.favorited_things.include?(current_thing)
      notice = "The thing was added to favorites."
      current_user.favorite(current_thing)
    end

    redirect_to root_path, notice: notice
  end

protected
  def favorited_things
    @favorited_things ||= current_user.favorited_things
  end
  helper_method :favorited_things
end
