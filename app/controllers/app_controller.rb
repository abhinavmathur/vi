class AppController < ApplicationController

  def index

  end

  def pricing

  end

  def search
    @reviews = Review.search(params[:q].present? ? params[:q] : '*')
  end

  def registration
    authenticate_user!
    @user = current_user
  end
end
