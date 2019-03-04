# == Schema Information
#
# Table name: task_statuses
#
#  id         :integer          not null, primary key
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TaskStatus < ActiveRecord::Base
  attr_accessible :status

  validates :status, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
end