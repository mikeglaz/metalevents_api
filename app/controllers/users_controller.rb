class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.activation_email(@user).deliver_now
      render json: @user, status: :created
      # render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def activation
    user = User.find_by(email: params[:email])

    if user&.authenticated?(:activation_digest, params[:token])
      user.update_attribute(:activated, true)
      render json: { status: 'User activated successfully.'}, status: :ok
    else
      render json: { status: 'Invalid token.' }, status: :not_found
    end

  end

  def login
    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      if user.activated?
        auth_token = JsonWebToken.encode({ user_id: user.id })
        render json: { auth_token: auth_token, user: user }, status: :ok
        # render json: user.merge(auth_token)
      else
        render json: { error: 'User not yet activated.'}, status: :unauthorized
      end
    else
      render json: { error: 'Invalid username/password.'}, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      #params.require(:user).permit(:name, :email, :password_digest, :activated, :admin, :activation_digest, :password_reset_digest)
      params.permit(:name, :email, :password)
    end
end
