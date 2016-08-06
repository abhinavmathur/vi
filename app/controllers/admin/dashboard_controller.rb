require 'amazon/ecs'

class Admin::DashboardController < ApplicationController

  def index
    @res = Amazon::Ecs.item_lookup("1591846447")
  end
end
