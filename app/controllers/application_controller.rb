class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :get_locale

  def bad_request_json(message)
   render json: { errors: message }, status: :bad_request
  end

  def render_404_page
    render :file => 'public/404_custom.html', :status => :not_found, :layout => false
  end

  protected

  def get_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
