class UserFavoritesController < ApplicationController
  before_filter :authenticate_user!

  def show; end

  def create
    current_user.favorite(current_thing)
    redirect_to root_path
  end

protected
  def favorited_things
    @favorited_things ||= current_user.favorited_things
  end
  helper_method :favorited_things
end
