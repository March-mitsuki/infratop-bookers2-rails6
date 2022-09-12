class BooksController < ApplicationController
  def home
  end

  def about
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), flash: {success: "create book successfully"}
    else
      @new_book = Book.new
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
    @new_book_comment = BookComment.new
    @book_comments = @book.book_comments.all
  end

  def index
    @new_book = Book.new
    @user = User.find(current_user.id)
    @books = Book.all
  end

  def destroy
    @book = Book.find(params[:id])

    if @book.user.id != current_user.id
      redirect_to books_path
      return
    end

    if @book.destroy
      redirect_to books_path, flash: {success: "destory book successfully"}
    else
      @new_book = Book.new
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
      return
    end
  end

  def update
    @book = Book.find(params[:id])

    if @book.user.id != current_user.id
      redirect_to books_path
      return
    end

    if @book.update(book_params)
      redirect_to book_path(params[:id]), flash: {success: "update book successfully"}
    else
      render :edit
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
end
