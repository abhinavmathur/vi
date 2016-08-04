class CategoriesController < ApplicationController
  def index
    @categories = Category.order('name DESC')
  end
end
