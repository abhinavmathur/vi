class ClickPointWorker
  include Sidekiq::Worker
  def perform(review_id, user_id)
    Click.create(review_id: review_id, user_id: user_id)
    review = Review.find(review_id)
    point = Point.find_or_create_by(reviewer_id: review.reviewer_id)
    new_points = point.points + 1
    point.update(points: new_points)
  end
end