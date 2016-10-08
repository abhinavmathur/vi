class ProductsController < ApplicationController

  before_action :authenticate_user!, except: :show
  before_action :set_product, except: [:new, :create]

  def new
    @product = Product.new
    authorize @product, :create?
  end

  def create
    if params[:product][:review_id].present?
      review_id = params[:product][:review_id].to_i
      unless Review.exists?(id: review_id)
        redirect_to request.referer and return
        flash[:error] = 'Invalid review_id supplied'
      end
    end
    @product = Product.create(product_params)
    @product.user_id = current_user.id
    if @product.save
      Review.find_by(id: review_id).update(reviewfiable: @product)
      flash[:notice] = 'Product was created successfully'
      redirect_to product_path(@product)
    else
      flash[:error] = @product.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    authorize @product, :update?
  end

  def show

  end

  def update
    authorize @product, :update?
    unless params[:product][:review_id].nil?
      review_id = params[:product][:review_id].to_i
      unless Review.exists?(id: review_id)
        redirect_to request.referer and return
        flash[:error] = 'Invalid review_id supplied'
      end
    end
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
      Review.find_by(id: review_id).update(reviewfiable: @product)
      flash[:notice] = 'Product was updated successfully'
      if params[:product][:review_id].present?
        review_id = params[:product][:review_id].to_i
        redirect_to product_path(@product, review_id: review_id)
      else
        redirect_to product_path(@product)
      end
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
                                   :affiliate_link, :publish, :review_id)
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
