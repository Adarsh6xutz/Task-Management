class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = generate_token(user)
      render status: :ok, json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def generate_token(user)
    # token will expire after 30 minutes
    JWT.encode({ exp: Time.now.to_i + 30.minutes, user_id: user.id }, JWT_SECRET_KEY, 'HS256')
  end
end
