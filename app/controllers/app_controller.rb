class AppController < ApplicationController

  def index

  end

  def pricing

  end

  def search
    @all_results = Searchkick.search(params[:q].present? ? params[:q] : '*', index_name: [Product, Review])
  end

  def search_joy
    user_id = nil
    if current_user
      user_id = current_user.id
    end
    search_value = Searchjoy::Search.create(
        search_type: params[:obj], # typically the model name
        query: params[:query],
        results_count: params[:results_count],
        user_id: user_id
    )
    if params[:obj] == 'Review'
      redirect_to review_path(Review.find(params[:id]))
      cookies[:convertable_id] = search_value.id;
    else
      redirect_to product_path(Product.find(params[:id]))
      cookies[:convertable_id] = search_value.id;
    end
  end

  def register
    authenticate_user!
    @user = current_user
  end

  def set_country
    country_code = params[:country_code].present? ? params[:country_code] : 'US'
    current_user.update(country_code: country_code)
    cookies[:country_code] = country_code
    respond_to do |format|
      format.js
    end
  end
end
