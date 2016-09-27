50.times {
  Category.create(
      name: Faker::Commerce.department(1, true)
  )
}

300.times {
  User.create(
      email: Faker::Internet.safe_email,
      avatar: Faker::Avatar.image,
      description: Faker::Lorem.sentences(1, true)
  )
}

def amazon_product_or_not
  if([true, false].sample)
    Faker::Code.asin
  else
    nil
  end
end

def product_images
  arr = []
  rand(1..10).to_i.times{
    arr.push(Faker::Placeholdit.image("50x50", 'jpg'))
  }
  arr.join(',')
end

def similar_products
  arr = []
  10.times {
    arr.push(Faker::Code.asin)
    arr.push(Faker::Commerce.product_name)
  }
  arr.join(',')
end

1000.times  {
  Product.create(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraphs(1, true),
      tags: Faker::Commerce.department(5),
      asin: amazon_product_or_not,
      category_id: rand(1..20),
      product_images: product_images,
      sub_category: Category.find(rand(1..20)).name,
      similar_products: similar_products,
      user_id: amazon_product_or_not.present? ? nil : rand(1..100),
      company: Faker::Company.name
  )
}
