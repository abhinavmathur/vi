class ProductsController < ApplicationController

  before_action :authenticate_user!, except: :show
  before_action :set_product, except: [:new, :create]

  def new
    @product = Product.new
    authorize @product, :create?
  end

  def create
    review_id = ''
    if params[:product][:review_id].present?
      review_id = params[:product][:review_id].to_i
      unless Review.exists?(id: review_id)
        review_id = ''
        flash[:error] = 'Invalid review_id supplied'
        redirect_to request.referer and return
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

    @product = Product.create(product_params)
    authorize @product, :create?
    @product.user_id = current_user.id
    if @product.save
      if review_id.present?
        Review.find_by(id: review_id).update(reviewfiable: @product)
        flash[:notice] = 'Product was updated successfully'
        redirect_to product_path(@product, review_id: review_id) and return
      else
        flash[:error] = @product.errors.full_messages.to_sentence
        redirect_to edit_product_path(@product, review_id: review_id) and return
      end
      flash[:notice] = 'Product was updated successfully'
      redirect_to product_path(@product) and return
    else
      flash[:error] = @product.errors.full_messages.to_sentence
      redirect_to edit_product_path(@product) and return
    end
  end

  def edit
    authorize @product, :update?
  end

  def show

  end

  def update
    authorize @product, :update?
    #checks for correct review_id supplied from params, if not correct, redirect back
    review_id = ''
    if params[:product][:review_id].present?
      review_id = params[:product][:review_id].to_i
      unless Review.exists?(id: review_id)
        flash[:error] = 'Invalid review_id supplied. Please follow the proper way of editing a product information'
        review_id = ''
        redirect_to edit_product_path(@product) and return
      end
    end

    #checks for correct mime type
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

    #checks for the owner of the review_id
    if review_id.present?
      review_owner = Review.find(review_id).reviewer_id
      unless review_owner == current_user.id
        flash[:error] = 'You are not allowed to change other reviews'
        redirect_to edit_product_path(@product) and return
      end
    end

    if @product.update(product_params)
      flash[:notice] = 'Product was updated successfully'
      if review_id.present?
        Review.find_by(id: review_id).update(reviewfiable: @product)
      end
      redirect_to product_path(@product, review_id: review_id) and return
    end
    flash[:error] = @product.errors.full_messages.to_sentence
    redirect_to product_path(@product, review: review_id) and return
  end

  def destroy
    authorize @product, :destroy?
    @product.destroy
    flash[:success] = 'Product was destroyed successfully'
    redirect_to root_path
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
