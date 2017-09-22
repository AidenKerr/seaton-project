class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def profile
    # Eventually this function will be used when given id, username, email, etc
    if User.exists?(params[:id]) #if given user ID
      @profile = User.find(params[:id])
    elsif User.exists?(email: params[:id] + ".ca") # if given email, :id cuts off after the period - must add ".ca" to the end
      @profile = User.where(email: params[:id] + ".ca").first
    end
  end

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user

    if @profile.update(user_params)
      flash[:notice] = "Profile #{@profile.email} updated"
      redirect_to root_path
    else
      redirect_to edit_user_url, :flash => { :error => @profile.errors.full_messages.join(',')}
    end
  end

  def user_params
    params.require(:user).permit(:username)
  end
end