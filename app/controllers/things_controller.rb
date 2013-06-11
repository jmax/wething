class ThingsController < ApplicationController
  before_filter :authenticate_user!

  def new; end

  def create
    if current_company.things << thing
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @thing = current_company.things.find(params[:id])
    current_user.view(@thing)
    redirect_to @thing.url
  end

protected
  def thing
    @thing ||= current_user.things.build(thing_params)
  end
  helper_method :thing

  def thing_params
    if params[:thing].present?
      params.require(:thing).permit(:url, :description)
    else
      {}
    end
  end

end
