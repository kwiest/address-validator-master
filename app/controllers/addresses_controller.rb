class AddressesController < ApplicationController
  def index
    render 'new'
  end

  def new
    @address_verification = AddressVerification.new
  end

  def create
    @address = Address.new(address_params)
    @address.save

    render 'new'
  end

  private

  def address_params
    params.permit(:city, :state)
  end
end
