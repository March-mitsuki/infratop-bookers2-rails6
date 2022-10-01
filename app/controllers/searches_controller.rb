class SearchesController < ApplicationController
  def search
    @results = nil
    @results_type = nil # 1 -> book, 2 -> user
    if search_params[:search_model] == "Book"
      case search_params[:search_type]
        when "完全一致" then
          @results = Book.where(title: search_params[:text])
        when "前方一致" then
          @results = Book.where("title LIKE ?", "#{search_params[:text]}%")
        when "後方一致" then
          @results = Book.where("title LIKE ?", "%#{search_params[:text]}")
        when "部分一致" then
          @results = Book.where("title LIKE ?", "%#{search_params[:text]}%")
        else
          redirect_to books_path, flash: {danger: "wrong search type error"}
          return
      end
      @results_type = 1
      render :results
    elsif search_params[:search_model] == "User"
      case search_params[:search_type]
        when "完全一致" then
          @results = User.where(name: search_params[:text])
        when "前方一致" then
          @results = User.where("name LIKE ?", "#{search_params[:text]}%")
        when "後方一致" then
          @results = User.where("name LIKE ?", "%#{search_params[:text]}")
        when "部分一致" then
          @results = User.where("name LIKE ?", "%#{search_params[:text]}%")
        else
          redirect_to books_path, flash: {danger: "wrong search type error"}
      end
      @results_type = 2
      render :results
    else
      redirect_to books_path, flash: {danger: "wrong model error"}
    end
  end

  private
    def search_params
      params.require(:search).permit(:text, :search_model, :search_type)
    end
end
