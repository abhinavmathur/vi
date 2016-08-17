class DeleteClicksWorker
  include Sidekiq::Worker
  def perform(review_id, user_id)
    click = Click.where(review_id: review_id, user_id: user_id).first
    click.destroy
  end
end