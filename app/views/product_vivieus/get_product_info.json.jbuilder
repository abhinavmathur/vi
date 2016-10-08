json.array! @product do |product|
  json.title product.title
  json.product_images product.product_images
  json.main_image product.product_images.split(',').first
  json.slug product.slug
end