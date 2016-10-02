class ProductsController < ApplicationController

  before_action :authenticate_user!, except: :show
  before_action :set_product, except: [:new, :create]

  def new
    @product = Product.new
    authorize @product, :create?
  end

  def create
    product = Product.new
    authorize product, :create?
    unless params[:product][:asin].nil?
      result, result_item = Product.from_amazon(params[:product][:asin])
      if result == 'notice'
        respond_to do |format|
          format.html {
            flash[:notice] = 'Product was created successfully'
            redirect_to product_path(result_item)
          }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :action => 'new'
          flash[:error] = result_item
          }
          format.js { render :action => 'new' }
        end
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
    authorize @product, :update?
  end

  def show

  end

  def update
    authorize @product, :update?
    if params[:product][:product_images].present?
      params[:product][:product_images].to_s.split(',').each do |image|
        mime = File.extname(image)
        unless Product.permitted_mimes.include?(mime)
          params[:product].delete(:product_images)
          flash[:error] = 'Images supplied did not match the permitted mime types. Links should end with .jpg or .png'
          redirect_to edit_product_path(@product) and return
        end
      end
    end
    if @product.update(product_params)
      flash[:notice] = 'Product was updated successfully'
      redirect_to product_path(@product)
    else
      flash[:error] = 'Something went wrong. Please check the form'
      render :edit
    end
  end

  def destroy
    authorize @product, :destroy?
  end



  private
  def product_params
    params.require(:product).permit(:title, :description, :category, :company, :tags, :product_images)
  end

  def review_params
    params.require(:review).permit(:title, :description, :youtube_url, :affiliate_tag,
                                   :affiliate_link, :publish)
  end



  def set_product
    begin
      @product = Product.friendly.find(params[:id])
    rescue
      flash[:error] = 'The product you were looking for could not be found'
      redirect_to root_path
    end
  end
end
