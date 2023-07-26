class Task < ApplicationRecord
  # task is assigned to user
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :user

  validates :title, :description, :task_date, :status, presence: true
  validates :status, inclusion: { in: %w[pending complete] }
end
