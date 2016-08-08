class ReviewsController < ApplicationController

  before_action :authenticate_user!, except: :show
  before_action :set_review

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
