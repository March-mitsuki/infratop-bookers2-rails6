class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @new_book = Book.new
  end

  def index
    @new_book = Book.new
    @user = User.find(current_user.id)
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
      return
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id), status: 303
      return
    end

    if @user.update(user_params)
      redirect_to user_path(params[:id]), status: 303, flash: {success: "update user successfully"}
    else
      render :edit, status: 303
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
end
