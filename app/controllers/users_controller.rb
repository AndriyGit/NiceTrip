class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def set_locale
    if ['en', 'ru'].include? params[:locale]
      session[:locale] = params[:locale]
    end
    redirect_to :back
  end

end