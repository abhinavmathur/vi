class ReviewsController < ApplicationController

  before_action :authenticate_user!, except: :show
  before_action :set_review, except: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    @product
    product_id = params[:product_id].to_i

    if Product.exists?(id: product_id)
      @product = Product.find_by(id: product_id)
    else
      flash[:error] = 'Wrong product ID supplied'
      redirect_to root_path
    end
    error_symbol, message, obj = ReviewCreationService.new(params, current_user, @product).create_review!
    if error_symbol == 'S'
      flash[:notice] = message.to_s
      redirect_to review_path(obj) and return
    else
      flash[:error] = message.to_s
      redirect_to new_review_path(product_id: product_id)
    end
  end

  def show
    ahoy.track 'Viewed review', id: @review.id
    if current_user
      unless current_user.dislikes?(@review)
        current_user.like(@review)
      end
    end
  end

  def edit

  end

  def update
    product_from_params = params[:product_id].to_i
    error_symbol, message, obj = ReviewCreationService.new(params, current_user, product_from_params).update_review!(@review)
    if error_symbol == 'S'
      flash[:notice] = message.to_s
      redirect_to review_path(obj) and return
    else
      flash[:error] = message.to_s
      redirect_to edit_review_path(obj)
    end
  end

  def destroy

  end

  def redirect_to_website
    unless Click.exists?(review_id: @review.id, user_id: current_user.id)
      ClickPointWorker.perform_async(@review.id, current_user.id)
      DeleteClicksWorker.perform_at(12.hours.from_now, @review.id, current_user.id)
    end

    unless params[:affiliate_website].present?
      flash[:error] = 'Affiliate website link not found'
      redirect_to review_path(@review)
    end
    if cookies[:convertable_id].present?
      begin
        search = Searchjoy::Search.find cookies[:convertable_id]
        search.convert
        cookies.delete(:convertable_id)
      end
    end
    redirect_to params[:affiliate_website]
  end



  private
  def review_params
    params.require(:review).permit(:title, :description, :youtube_url, :affiliate_tag,
                                   :affiliate_link,  :publish, :tags, :reviewgroup_id)
  end

  def set_review
    @review = Review.friendly.find(params[:id])
  end
end
