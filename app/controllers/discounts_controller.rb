class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:new, :index, :create]
  before_action :find_merchant_and_discount, only: [:show, :destroy, :edit]

  def index 
    @discounts = @merchant.discounts
    @holidays = HolidayService.get_holidays.first(3)
  end

  def show

  end

  def edit

  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    if discount.update(require_discount_params)
      redirect_to merchant_discount_path(@merchant, discount)
      flash.notice = "Discount Has Been Updated!"
    else
      redirect_to edit_merchant_discount_path(@merchant, discount)
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  def new
    
  end

  def create
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
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  private
  def discount_params
    params.permit(:percentage, :threshold, :merchant_id, :id)
  end

  def require_discount_params
    params.require(:discount).permit(:percentage, :threshold, :merchant_id, :id)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant_and_discount
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end
end