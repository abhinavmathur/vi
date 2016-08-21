class ReviewCreationService

  attr_reader :params, :user, :product

  def initialize(params, user, product)
    @params = params
    @user = user
    @product = product
  end

  def create_review!
    if has_youtube_url?
      unless Review.youtube_video_belongs_to_user?(user, params[:review][:youtube_url])
        return ['E', 'The YouTube video ID is either invalid or does not belong to you', nil]
      end
    end

    review = product.reviews.create(review_params)
    review.reviewer_id = user.id
    review.affiliate_link =  "http://www.amazon.com/dp/#{review.reviewfiable.asin}/?tag=#{review.affiliate_tag}"
    if review.save
      return ['S', 'Your review was saved successfully', review]
    else
      return ['E', 'Your review was not created', review]
    end

  end



  private
  def review_params
    params.require(:review).permit(:title, :description, :youtube_url, :other_video_url, :affiliate_tag,
                                   :affiliate_link, :has_youtube_link, :publish, :tags)
  end

  def has_youtube_url?
    params[:review][:youtube_url].present?
  end
end