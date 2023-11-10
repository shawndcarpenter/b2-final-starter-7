class DiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    if discount.update(require_discount_params)
      #(percentage: params[:percentage], threshold: params[:threshold])
      redirect_to merchant_discount_path(@merchant, discount)
      flash.notice = "Discount Has Been Updated!"
    else
      redirect_to edit_merchant_discount_path(@merchant, discount)
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
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
    params.permit(:percentage, :threshold, :merchant_id, :id)
  end
  def require_discount_params
    params.require(:discount).permit(:percentage, :threshold, :merchant_id, :id)
  end
end