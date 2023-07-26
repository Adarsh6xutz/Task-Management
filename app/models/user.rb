class User < ApplicationRecord
  has_secure_password

  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id'
  has_many :tasks

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: {in: %w[client employee manager] }

  def client?
    role == 'client'
  end

  def manager?
    role == 'manager'
  end

  def employee?
    role == 'employee'
  end
end
