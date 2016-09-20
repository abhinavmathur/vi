class CardsController < ApplicationController

  def create
    customer = Stripe::Customer.create(
                        card: params[:stripeToken],
                        email: current_user.email,
                        description: 'Reviewer registration at Vivieu'
    )

    user_params = {
        card_last4: params[:card_last4],
        card_exp_month: params[:card_exp_month],
        card_exp_year: params[:card_exp_year],
        card_brand: params[:card_brand],
        reviewer: true,
        stripe_id: customer.id
    }

    if current_user.update_attributes(user_params)
      flash[:notice] = 'Congratulations ! Your have successfully registered as a reviewer'
      redirect_to reviewer_root_path
    else
      flash[:error] = 'There was some problem with the registration. Please try again'
      redirect_to registration_path
    end
  end

  def update
#todo BP update card functionality
  end

  private
end
