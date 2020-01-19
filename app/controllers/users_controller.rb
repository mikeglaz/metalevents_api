class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  before_action :authorize_request!, except: [:activation, :login, :create]
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
      render json: { message: "An activation email has been sent to #{@user.email}." }, status: :created
      # render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end

    rescue ActiveRecord::RecordNotUnique
      render json: { message: 'Email already exists.' }, status: :conflict
  end

  # PATCH/PUT /users/1
  def update
    if @current_user.admin? && @user.update(user_params)
      render json: { message: "User successfully updated!"}, status: :created
      # render json: @user
    else
      render json: { error: @user.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    if @current_user.admin?
      @user.destroy
    end
  end

  def activation
    decoded_token = JsonWebToken.decode(params[:token])[0]

    if decoded_token
      user = User.find_by(email: decoded_token['email'])
    end

    if user #&.authenticate_digest(:activation_digest, params[:token])
      user.update_attribute(:activated, true)
      # render json: { status: 'User activated successfully.'}, status: :ok
      # render 'users/activation'
      redirect_to "http://localhost:4200/auth/activation"
    else
      redirect_to "http://localhost:4200/auth/activation_error"
      # render json: { status: 'Invalid token.' }, status: :not_found
    end

    rescue JWT::VerificationError, JWT::ExpiredSignature, JWT::DecodeError
      redirect_to "http://localhost:4200/auth/activation_error"

  end

  def login
    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      if user.activated?
        token = JsonWebToken.encode({ id: user.id, email: user.email, name: user.name, admin: user.admin })

        render json: { token: token }, status: :ok

        # render json: { token: auth_token, id: user.id, name: user.name, email: user.email, admin: user.admin }, status: :ok
      else
        render json: { message: 'User not yet activated.'}, status: :unauthorized
      end
    else
      render json: { message: 'Invalid username/password.'}, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password)

      # params.permit(:name, :email, :password)
    end
end
