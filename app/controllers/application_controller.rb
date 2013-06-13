class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

protected
  def current_thing
    @thing ||= current_company.things.find(params[:thing_id] || params[:id])
  end
  helper_method :current_thing

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:email, :password)
    end

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :first_name, :last_name, :email, :password, :password_confirmation,
        { company_attributes: :name }
      )
    end
  end

  def current_company
    @company ||= current_user.company if current_user
  end
  helper_method :current_company
end
