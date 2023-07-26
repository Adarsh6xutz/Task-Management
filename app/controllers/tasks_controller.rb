class TasksController < ApplicationController
  before_action :set_task, except: :create
  before_action :authorize_manager, only: [:set_assignee, :destroy]
  before_action :authorize_employee, only: [:complete]
  before_action :authorize_client, only: [:create, :update]

  def create
    # task is created with default status as pending
    task = @current_user.tasks.build(task_params.merge(status: 'pending'))
    if task.save
      render status: :ok, json: task
    else
      render json: { error: task.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def update
    render status: :ok, json: @task
  end

  def set_assignee
    # checking if the email is valid and role is employee
    user = User.find_by(email: params[:email], role: 'employee')
    if user.present?
      @task.update(assignee_id: user.id)
      render status: :ok, json: @task
    else
      render status: :ok, json: {error: 'Employee not found'}
    end
  end

  def destroy
    if @task.destroy
      render status: :ok, json: {}
    end
  end

  # employee can mark status as completed
  def complete
    # checking if employee has the task which he is marking completed
    if @current_user.assigned_tasks.include?(@task)
      @task.update(status: 'complete')
      render json: @task
    else
      render status: :unauthorized, json: { error: 'Task is not assigned to you' }
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :task_date)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
    render json: { error: 'Task not found' }, status: :not_found if @task.blank?
  end

  def authorize_client
    render_unauthorized unless @current_user.client?
  end

  def authorize_manager
    render_unauthorized unless @current_user.manager?
  end

  def authorize_employee
    render_unauthorized unless @current_user.employee?
  end

  def render_unauthorized
    render json: { error: 'You are not authorized to perform this action' }, status: :unauthorized
  end
end
