class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
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
      flash[:notice] = "User created!"
      redirect_to(admin_users_path)
    else
      flash[:alert] = "User not created"  #@user.errors
      render 'new'
    end
  end


  def edit
    @user = User.find(params[:id])
    @user_roles_ids = @user.roles.pluck(:role_id)

    if @user.active
      @panel_title = "Deactivate account"
      @btn_text = "Set Inactive"
    else
      @panel_title = "Activate account"
      @btn_text = "Set Active"
    end
  end


  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])

      flash[:notice] = "Profile updated"
      redirect_to(admin_user_path(@user))
    else
      flash[:alert] = "User profile not updated"
      redirect_to(admin_user_path(@user))
    end

  end


  def destroy
    @user = User.find(params[:id])
    # if User.find(params[:id]).destroy
    #   flash[:notice] = "User deleted"
    #   redirect_to(admin_users_path)
    # elsif
    #   flash[:alert] = "User not deleted"
    #   redirect_to(admin_user_path(@user))
    # end
  end

  def activation
    @user = User.find(params[:id])

    if @user.active
      message = "deactivation"
      @user.password = Devise.friendly_token.first(8) #generated password
    else
      message = "activation"
    end

    @user.toggle(:active)

    if @user.save
      flash[:notice] = "User "+message+" successful"
    elsif
      flash[:alert] = "User "+message+" unsuccessful"
    end

    redirect_to admin_user_path(@user)
  end




  private

  def current_user?(user)
    user == current_user
  end



end