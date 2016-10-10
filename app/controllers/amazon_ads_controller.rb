class AmazonAdsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_product_vivieu
  before_action :set_amazon_ad, only: [:show, :edit, :update, :destroy]

  def new
    @amazon_ad = AmazonAd.new
  end

  def create
    @amazon_ad = @product_vivieu.create_amazon_ad(amazon_ad_params)
    if @amazon_ad.save
      respond_to do |format|
        format.html {
          redirect_to edit_product_vivieu_path(@product_vivieu)
          flash[:notice] = 'Amazon native ad created'
        }
        format.js{
          @amazon_ad
        }
      end
    else
      respond_to do |format|
        format.html {
          flash[:error] = 'There was a problem. Please check the form below'
          render :new
        }
        format.js{
          flash[:error] = @amazon_ad.errors.full_messages.to_sentence
        }
      end
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    respond_to do |format|
      if @amazon_ad.update(amazon_ad_params)
        format.js{
        }
      else
        format.js{
          flash[:error] = @amazon_ad.errors.full_messages.to_sentence
        }
      end
    end
  end

  def destroy
    @amazon_ad.destroy

  end

  private

  def set_product_vivieu
    @product_vivieu = Review.friendly.find(params[:product_vivieu_id])
  end

  def set_amazon_ad
    begin
      @amazon_ad = AmazonAd.find(params[:id])
    rescue
      flash[:error] = 'The Amazon Ad ID you entered was incorrect'
      redirect_to edit_product_vivieu_path(@product_vivieu)
    end

  end

  def amazon_ad_params
    params.require(:amazon_ad).permit(:link_id, :title, :asins)
  end
end
