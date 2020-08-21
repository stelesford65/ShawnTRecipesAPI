class UserController < ApplicationController
  before_action :authorized, only: [:auto_login]
  #creates a new user then return the user and their token
  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end
  # Check if the users password matches, if so return the user and their token
  # LOGGING IN
  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end
  #test route, returns user if auth is successful, won't if it doesn't
  def auto_login
    render json: @user
  end
  private
  # helper function to capture info from request body
  def user_params
    params.permit(:username, :password, :age)
  end
end