class ReviewgroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user
  before_action :set_reviewgroup, except: [:new, :create, :index]

  def index
    @reviewgroups = @user.reviewgroups.order('created_at DESC')
  end

  def new
    @reviewgroup = Reviewgroup.new
  end

  def create
    @reviewgroup = @user.reviewgroups.create(reviewgroup_params)
    @reviewgroup.user_id = current_user.id
    if @reviewgroup.save
      flash[:notice] = "Video review group = '#{@reviewgroup.title}' was successfully created"
      redirect_to user_reviewgroups_path(current_user)
    else
      flash[:error] = 'Video review group was not created'
      render :new
    end
  end

  def edit

  end

  def update
    if @reviewgroup.update(reviewgroup_params)
      flash[:notice] = "Video review group was edited to = '#{@reviewgroup.title}'"
      redirect_to user_reviewgroups_path(current_user)
    else
      flash[:error] = 'Video review group was not updated'
      render :edit
    end
  end


  def destroy
    @reviewgroup.destroy
    flash[:notice] = 'Video review group was successfully deleted'
    redirect_to user_reviewgroups_path(@user)
  end

  private
  def reviewgroup_params
    params.require(:reviewgroup).permit(:title, :short_description, :category_id)
  end

  def set_reviewgroup
    @reviewgroup = Reviewgroup.friendly.find(params[:id])
  end

  def set_user
    @user = User.friendly.find(params[:user_id])
  end
end
