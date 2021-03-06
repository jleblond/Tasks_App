class AssignationObserver < ActiveRecord::Observer
  observe :assignation

  def after_create(assignation)
    task_id = assignation.task_id
    notif_message = "Task "+Task.find(task_id).task_name+" was assigned to you"

    if User.current.present?
      notif_message += " by "+User.current
    end

    Notification.create(description: notif_message, user_id: assignation.user_id, read: false)


  end


end