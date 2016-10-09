unless @product.errors.any?
  json.title @product.title
  json.product_images @product.product_images
  json.slug @product.slug
end
