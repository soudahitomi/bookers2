class UsersController < ApplicationController
  def index

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @users = User.all
  end

  def edit
  end
end