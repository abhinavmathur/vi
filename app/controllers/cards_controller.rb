class CardsController < ApplicationController

  def create
    user_params = {
        card_last4: params[:card_last4],

    }
  end

  def update

  end

  private
end
