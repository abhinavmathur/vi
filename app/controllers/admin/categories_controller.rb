class Admin::CategoriesController < Admin::DashboardController

  before_action :set_category, except: [:index, :new, :create]


  def index
    @categories = Category.order('name DESC')
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      redirect_to admin_category_path(@category)
      flash[:success] = 'Category was created successfully'
    else
      flash[:danger] = 'Category was not created'
      render :new

    end
  end

  def show

  end

  def edit

  end

  def update
    if @category.save
      redirect_to admin_category_path(@category)
      flash[:success] = 'Category was created updated'
    else
      flash[:danger] = 'Category was not updated'
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_root_path
    flash[:success] = 'Category was deleted'
  end

  private
   def category_params
     params.require(:category).permit(:name, :description)
   end

  def set_category
    @category = Category.find(params[:id])
  end
end
