class DiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.new(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(@merchant)
      flash.notice = "Discount Has Been Created!"
    else 
      redirect_to new_merchant_discount_path(@merchant)
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  private
  def discount_params
    params.permit(:percentage, :threshold)
  end
end