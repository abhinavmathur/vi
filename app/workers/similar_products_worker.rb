class SimilarProductsWorker
  include Sidekiq::Worker

  def perform(asin)
    SimilarProducts.new(asin).create!
  end

end

