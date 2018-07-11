class AddressesController < ApplicationController
  def index
    render 'new'
  end

  def show
    @address = Address.find(params[:id])
  end

  def new
    @address_verification = AddressVerification.new
  end

  def create
    @address_verification = AddressVerification.new(address_verification_params)

    if @address_verification.save
      @address = Address.create(@address_verification.to_address_params)
      redirect_to @address, notice: 'Address successfully validated!'
    else
      render 'new'
    end
  end

  private

  def address_verification_params
    params.require(:address_verification)
      .permit(:street_address, :city, :state, :zip_code)
  end
end
