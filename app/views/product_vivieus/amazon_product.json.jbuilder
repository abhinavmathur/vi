json.title @product.title
json.image @product.product_images
json.slug @product.slug
json.main_image @product.product_images.split(',').first

