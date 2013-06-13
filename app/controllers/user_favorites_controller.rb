class UserFavoritesController < ApplicationController

  def create
    @thing = current_company.things.find(params[:thing_id])
    current_user.favorite(@thing)
    redirect_to root_path
  end

  def show
    respond_to do |format|
      format.html # show.html.slim
    end
  end

end
