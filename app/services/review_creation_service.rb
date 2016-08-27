class ReviewCreationService

  attr_reader :params, :user, :product

  def initialize(params, user, product)
    @params = params
    @user = user
    @product = product
  end

  def create_review!
    unless Review.youtube_video_belongs_to_user?(user, params[:review][:youtube_url])
      return ['E', 'The YouTube video ID is either invalid/private/non-embeddable or does not belong to you', nil]
    end

    review = product.reviews.create(review_params)
    review.reviewer_id = user.id
    if review.affiliate_link.nil?
      review.affiliate_link =  "http://www.amazon.com/dp/#{review.reviewfiable.asin}/?tag=#{review.affiliate_tag}"
    end
    if review.save
      return ['S', 'Your review was saved successfully', review]
    else
      return ['E', 'Your review was not created', review]
    end

  end

  def update_review!(updated_review)
    #prevent api request from happening again
    unless updated_review.youtube_url == params[:review][:youtube_url].to_s
      unless Review.youtube_video_belongs_to_user?(user, params[:review][:youtube_url])
        return ['E', 'The YouTube video ID is either invalid/private/non-embeddable or does not belong to you', updated_review]
      end
    end

    if updated_review.update(review_params)
      updated_review.update(slug: params[:review][:title].to_s)
      return ['S', 'Your review was updated successfully', updated_review]
    else
      return ['E', 'Your review was not updated', updated_review]
    end
  end



  private
  def review_params
    params.require(:review).permit(:title, :description, :youtube_url,  :affiliate_tag,
                                   :affiliate_link, :publish, :tags, :reviewgroup_id)
  end
end