class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    end
  end

  def show
    @users = User.find(params[:id])
    @books = Book.find(params[:id])
    @user = current_user
    @book = Book.new
  end

  def edit
    @books = Book.find(params[:id])
    @book = Book.new
    @user = current_user
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
        flash[:notice] = "you have updated book successfully."
    redirect_to book_path
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path

  end
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
