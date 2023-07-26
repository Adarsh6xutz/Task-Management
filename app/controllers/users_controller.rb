class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    u_params = user_params
    # setting role as employee if role is not provided
    u_params[:role] = 'employee' if user_params[:role].blank?
    user = User.new(u_params)
    if user.save
      render status: :ok, json: user
    else
      render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
  end
end
