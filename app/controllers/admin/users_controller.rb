class Admin::UsersController < ApplicationController
  before_filter :role_admin?


  def index
    @users = User.all

  end

  def show
    @user = User.find(params[:id])
  end

  def new

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User created!"
      redirect_to(admin_users_path)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])

      flash[:success] = "Profile updated"
      redirect_to(admin_user_path(@user))
    else
      redirect_to(admin_user_path(@user))
    end

  end


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to(admin_users_path)
  end

  private


  def current_user?(user)
    user == current_user
  end



end