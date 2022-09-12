class BookCommentsController < ApplicationController
  def create
    current_book = Book.find(params[:book_id])
    comment = current_book.book_comments.new(comment_params)
    comment.user_id = current_user.id
    comment.save
    redirect_back fallback_location: books_path, status: 303
  end

  def destroy
    comment = BookComment.find(params[:id])
    if comment.user.id == current_user.id
      comment.destroy
      redirect_back fallback_location: books_path, status: 303  
      return  
    else
      redirect_back fallback_location: books_path, status: 303
      return
    end
  end

  private
    def comment_params
      params.require(:book_comment).permit(:comment)
    end
end
