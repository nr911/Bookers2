class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    @user.save
    flash[:success] = ""
    redirect_to user_path
  end

  def index
    @users = User.all
    @user = current_user
    @newbook = Book.new
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @user_image = User.find(params[:id])
    @books = @user.books
    @newbook = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render 'edit'
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
