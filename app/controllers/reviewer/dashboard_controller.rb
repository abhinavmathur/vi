class Reviewer::DashboardController < ApplicationController
  layout 'reviewer'

  def index

  end

  def autocomplete
    render json: Product.search(params[:query], {
        fields: ["title","asin"],
        limit: 15,
        misspellings: {below: 5}
    }).map(&:title)
  end

  def product_search

  end

end
