class UsersController < ApplicationController

  before_filter :authenticate_user!, only: :show

  def show
  end

  def edit_user
    if params[:type].present? && %w{ name password }.include?(params[:type])
      respond_to do |format|
        format.js
      end
    else
      redirect_to my_account_path
    end
  end

  def save_user_name
    current_user.update_attributes(first_name: params[:first_name], last_name: params[:last_name])
    unless current_user.valid?
      current_user.reload
      render json: { errors: current_user.errors.messages.values.flatten.first }, status: :bad_request
    end and return
    head :ok
  end

  def save_user_password
    current_user.change_password(params[:current_password], params[:password], params[:password_confirmation])
    unless current_user.errors.empty?
      render json: { errors: current_user.errors.messages.values.flatten.first }, status: :bad_request
    end and return
    head :ok
    sign_in(current_user.reload, bypass: true)
  end

  def set_locale
    if ['en', 'ru'].include? params[:locale]
      session[:locale] = params[:locale]
    end
    redirect_to :back
  end

  def upload_avatar
    current_user.update_attributes(params.require(:user).permit(:image))
    redirect_to my_account_path
  end

  def delete_avatar
    current_user.remove_image = true
    current_user.save!
    redirect_to my_account_path
  end

end