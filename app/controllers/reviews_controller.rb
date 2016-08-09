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
      redirect_to root_path and return
    end
    @review = @product.reviews.create(review_params)
    @review.reviewer_id = current_user.id
    if @review.save
      flash[:notice] = 'Review was created successfully'
      redirect_to review_path(@review)
    else
      flash[:error] = @review.errors.full_messages.to_sentence
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

  private
  def review_params
    params.require(:review).permit(:title, :description, :youtube_url, :other_video_url, :affiliate_tag,
                                   :affiliate_link, :has_youtube_link, :publish)
  end

  def set_review
    @review = Review.friendly.find(params[:id])
  end
end
