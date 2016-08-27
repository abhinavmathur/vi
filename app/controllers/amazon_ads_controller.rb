class AmazonAdsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_review
  before_action :set_amazon_ad, only: [:edit, :update, :destroy]

  def new
    @amazon_ad = AmazonAd.new
  end

  def create
    @amazon_ad = @review.create_amazon_ad(amazon_ad_params)
    if @amazon_ad.save
      redirect_to edit_review_path(@review)
      flash[:notice] = 'Amazon native ad created'
    else
      flash[:error] = 'There was a problem. Please check the form below'
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def set_review
    @review = Review.friendly.find(params[:review_id])
  end

  def set_amazon_ad
    @amazon_ad = AmazonAd.find(params[:id])
  end

  def amazon_ad_params
    params.require(:amazon_ad).permit(:link_id, :title, :asins)
  end
end
