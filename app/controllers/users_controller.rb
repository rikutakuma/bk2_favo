class UsersController < ApplicationController
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
      )
    if @user.save
      flash[:notice] = "Signed in successfully."
      redirect_to users_pash(user.id)
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.follows.all
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
