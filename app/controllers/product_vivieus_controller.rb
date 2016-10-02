class ProductVivieusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product_vivieu, except: [:new, :create]

  def new
    render layout: false
  end

  def create
    @product_vivieu = Review.create(create_review_params)
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

  end

  def update
    respond_to do |format|
      if @product_vivieu.update(edit_review_params)
        format.html {
          flash[:notice] = 'Your review was successfully saved'
          redirect_to edit_product_vivieu_path(@product_vivieu) and return
        }
        format.json {
          render json: nil, status: :ok
        }
      else
        format.html {
          flash[:error] = @product_vivieu.errors.full_messages.to_sentence
          redirect_to edit_product_vivieu_path(@product_vivieu) and return
        }
        format.js {
          @errors = @product_vivieu.errors
        }
      end
    end
  end

  def destroy
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

  private
  def create_review_params
    params.require(:review).permit(:title)
  end

  def edit_review_params
    params.require(:review).permit(:title, :description, :tags, :youtube_url, :affiliate_tag, :affiliate_link, :product_id)
  end

  def set_product_vivieu
    @product_vivieu = Review.friendly.find(params[:id])
  end
end
