class DiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
  end
end