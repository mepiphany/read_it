class UsersController < ApplicationController
  before_action :find_user, except: [:index, :new, :create]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      redirect_to root_path, notice: "User Created!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(users_params)
      redirect_to root_path, notice: "User Updated"
    else
      render :edit
    end
  end




  private

  def users_params
    params.require(:user).permit([:email, :password, :password_confirmation])
  end

  def find_user
    @user = User.find(params[:id])
  end



end
