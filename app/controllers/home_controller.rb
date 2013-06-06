class HomeController < ApplicationController
  def index; end

protected
  def things
    @things ||= current_user.company.things
  end
  helper_method :things
end
