class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?


  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to root_path, :alert => exception.message
    else
      redirect_to new_user_session_path, :alert => "Please sign in"
    end
  end

  def self.return_json *args
    before_filter :set_json_format, *args
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :avatar
    devise_parameter_sanitizer.for(:sign_up) << :avatar
  end

private

  def render_invalid obj
    render json: { errors: obj.errors.full_messages }, status: 422
  end

  def set_json_format
    request.format = :json
  end

end
