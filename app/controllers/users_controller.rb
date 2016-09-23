class UsersController < ApplicationController

  before_action :set_user

  def show
    
  end

  private
  def reviewgroup_params
    params.require(:reviewgroup).permit(:title, :short_description, :category_id, :user_id)
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
