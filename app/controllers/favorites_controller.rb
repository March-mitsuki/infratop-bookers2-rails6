class FavoritesController < ApplicationController
  def create
    current_book = Book.find(params[:book_id])
    if Favorite.exists?(user_id: current_user.id, book_id: current_book.id)
      redirect_back fallback_location: books_path
      return
    else
      @favorate = current_user.favorites.new(book_id: current_book.id)
      @favorate.save
      return
    end
  end

  def destroy
    @favorate = Favorite.find_by(book_id: params[:book_id])
    @favorate.destroy
  end
end
