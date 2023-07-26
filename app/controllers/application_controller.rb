class ApplicationController < ActionController::Base
  JWT_SECRET_KEY = 'jwt_secret_key'
  protect_from_forgery
  before_action :authenticate_user

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      decoded_token = JWT.decode(token, JWT_SECRET_KEY, true, algorithm: 'HS256')
      user_id = decoded_token[0]['user_id']
      @current_user = User.find_by(id: user_id)
    else
      render json: { error: 'Authorization token missing or invalid' }, status: :unauthorized
    end
  rescue JWT::ExpiredSignature
    render json: { error: 'Token Expired' }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { error: 'Authorization token missing or invalid' }, status: :unauthorized
  end
end
