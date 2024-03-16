class UsersController < ApplicationController
  before_action :authenticate_user!
  def index

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
  end
end