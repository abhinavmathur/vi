class ProductsController < ApplicationController

  before_action :authenticate_user!, except: :show
  before_action :set_product, except: [:new, :create]

  def new
    @product = Product.new
  end

  def create
    unless params[:product][:asin].nil?
      result, result_item = Product.from_amazon(params[:product][:asin])
      if result == 'notice'
        flash[:notice] = 'Product was created successfully'
        redirect_to product_path(result_item)
      else
        flash[:error] = result_item
        render :new
      end
    else
      @product = Product.create(product_params)
      @product.user_id = current_user.id
      if @product.save
        flash[:notice] = 'Product was created successfully'
        redirect_to product_path(@product)
      else
        flash[:error] = 'Something went wrong. Please check the form'
        render :new
      end
    end
  end

  def edit

  end

  def show

  end

  def update
    if @product.update(product_params)
      flash[:notice] = 'Product was updated successfully'
      redirect_to product_path(@product)
    else
      flash[:error] = 'Something went wrong. Please check the form'
      render :edit
    end
  end



  private
  def product_params
    params.require(:product).permit(:title, :description, :category, :company, :tags)
  end

  def review_params
    params.require(:review).permit(:title, :description, :youtube_url, :other_video_url, :affiliate_tag,
                                   :affiliate_link, :has_youtube_link, :publish)
  end


  def set_product
    @product = Product.friendly.find(params[:id])
  end
end
