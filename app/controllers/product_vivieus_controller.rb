class ProductVivieusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product_vivieu, only: [:edit, :update, :destroy, :amazon_product, :add_product,
                                            :publish, :unpublish, :add_target_country, :affiliate_category]

  def new
    authorize Review.new, :create?
    render layout: false
  end

  def create
    authorize @product_vivieu, :create?
    @product_vivieu = Review.create(create_review_params)
    @product_vivieu.reviewer_id = current_user.id
    if @product_vivieu.save
      flash[:notice] = 'The title for your product review was successfully created !'
      redirect_to edit_product_vivieu_path(@product_vivieu)
    else
      respond_to do |format|
        format.html {
          flash[:error] = @product_vivieu.errors.full_messages.to_sentence
          redirect_to root_path
        }
        format.js {
          @error = @product_vivieu.errors.full_messages.to_sentence
        }
      end
    end
  end

  def edit
    authorize @product_vivieu, :update?

  end

  def update
    authorize @product_vivieu, :update?
    respond_to do |format|
      if @product_vivieu.update(edit_review_params)
        format.html {
          flash[:notice] = 'Your review was successfully saved'
          redirect_to edit_product_vivieu_path(@product_vivieu) and return
        }
        format.json {
          flash[:success] = 'Form saved !'
          render json: nil, status: :ok
        }
      else
        format.html {
          flash[:error] = @product_vivieu.errors.full_messages.to_sentence
          redirect_to edit_product_vivieu_path(@product_vivieu) and return
        }
        format.js {
          flash[:error] = 'There were error(s) while submitting the form'
          @errors = @product_vivieu.errors
        }
      end
    end
  end

  def destroy
    authorize @product_vivieu, :destroy?
    @product_vivieu.destroy
    flash[:notice] = 'The review was deleted'
    redirect_to root_path
  end

  def youtube_videos
    begin
      account = Yt::Account.new(refresh_token: current_user.refresh_token)
      @videos = account.videos
    rescue => e
      flash[:error] = e.to_s
      redirect_to edit_product_vivieu_path(@product_vivieu)
    end
  end

  def autocomplete
    @products = Product.search(params[:query], {
        fields: ['title'],
        limit: 15,
        misspellings: {below: 5}
    })

  end

  def add_product
    if params[:product_id].present?
      product_id = params[:product_id].to_i
      product = Product.find(product_id)
      if product.errors.any?
        render :json => { :errors => product.errors.full_messages }, :status => 422
      else
        @product_vivieu.update(reviewfiable: product)
        @product = product
      end
    end
  end

  def amazon_product
    asin = params[:product][:asin]
    result, obj = Product.from_amazon(asin)
    if result == 'duplicate' or result == 'notice'
      if @product_vivieu.update(reviewfiable: obj)
        @product = obj
      else
        render json: obj.errors, status: :unprocessable_entity
      end
    else
      render json: obj, status: :unprocessable_entity
    end
  end

  def publish
    if @product_vivieu.update(edit_review_params.merge(publish: true))
      respond_to do |format|
        format.html {
          redirect_to review_path(@product_vivieu) and return
        }
        format.json {
          render json: nil, status: :ok
        }
      end
    else
      respond_to do |format|
        format.json{
          render json: @product_vivieu.errors.full_messages, status: 422
        }
      end
    end
  end

  def unpublish
    @product_vivieu.update(publish: false)
    flash[:notice] = 'The review was unpublished'
    redirect_to edit_product_vivieu_path(@product_vivieu)
  end

  def add_target_country
    target_country_array = ['']
    unless @product_vivieu.target_countries.nil?
      target_country_array = @product_vivieu.target_countries.split(',')
    end
    target_country = params[:target_country]
    target_country_array.push(target_country).uniq
    if @product_vivieu.update(target_countries: target_country_array.join(','))
      code = GeoLink.get_country_code(target_country)
      geolink = GeoLink.new(code).amazon_search_link(@product_vivieu, current_user)
      render json: geolink, status: :ok
    end
  end

  def affiliate_category
    affiliate = params[:affiliate]
    if affiliate == 'Amazon'
      @product_vivieu.update(affiliate_category: true)
      render json: nil, status: :ok
    else
      @product_vivieu.update(affiliate_category: false)
      render json: nil, status: :ok
    end
  end

  private
  def create_review_params
    params.require(:review).permit(:title)
  end

  def edit_review_params
    params.require(:review).permit(:title, :description, :tags, :youtube_url, :affiliate_tag, :affiliate_link, :product_id, :target_countries)
  end

  def set_product_vivieu
    @product_vivieu = Review.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :category_id, :company, :tags, :product_images)
  end
end
