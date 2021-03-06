class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @notifications = current_user.notifications

    # @notifications.pluck(:id).each do |n_id|
    #   Notification.find(n_id).update_attributes(read: true)
    # end

  end


  def destroy
    Notification.find(params[:id]).destroy
    redirect_to notifications_url
  end



  def edit #mark as read
    Notification.find(params[:id]).update_attributes(read: true)
    redirect_to(notifications_path)
  end

end