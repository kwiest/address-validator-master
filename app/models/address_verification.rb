class AddressVerification
  include ActiveModel::Model

  attr_accessor :street_address, :city, :state, :zip_code

  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true,
    numericality: true,
    length: { is: 5 }
end
