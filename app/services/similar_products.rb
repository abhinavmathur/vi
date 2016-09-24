class SimilarProducts
	require 'amazon/ecs'

	def initialize(asin)
		@asin = asin
	end

	def create!
	product = Product.find_by(asin: @asin)
    similar_products = Amazon::Ecs.similarity_lookup(@asin)
    similar_products_hash = Hash.new
    arr = Array.new
    	similar_products.items.each do |item|
    		arr.push([item.get('ASIN').to_s, item.get('ItemAttributes/Title').to_s])
		end
	product.update(similar_products: arr.join(','))
	end
end
