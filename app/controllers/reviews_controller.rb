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

  end

  def edit

  end

  def update

  end

  def destroy

  end

  def redirect_to_website
    unless params[:affiliate_website].present?
      flash[:error] = 'Affiliate website link not found'
      redirect_to review_path(@review)
    end
    website = params[:affiliate_website]
    Click.find_or_create_by(review_id: @review.id, user_id: current_user.id)
    redirect_to 'http://www.amazon.ca'
  end

  private
  def review_params
    params.require(:review).permit(:title, :description, :youtube_url, :other_video_url, :affiliate_tag,
                                   :affiliate_link, :has_youtube_link, :publish, :tags)
  end

  def set_review
    @review = Review.friendly.find(params[:id])
  end
end
