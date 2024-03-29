class BooksController < ApplicationController
  before_action :is_matching_login_user?, only: [:edit, :update]


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
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    # @users = User.find(params[:id])アソシエーションしているのでviewでは、@books.user.nameとかで使える
    @books = Book.find(params[:id])
    @user = current_user
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
  end

  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
        flash[:notice] = "you have updated book successfully."
        redirect_to book_path
    else

      render :edit
    end
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

  def is_matching_login_user?# メソッド名はコントローラごとに変える。
    book = Book.find(params[:id])
    unless book.user_id  == current_user.id#ここのbook.user_idが最後まで分からなかったです
      redirect_to books_path
    end
  end
end