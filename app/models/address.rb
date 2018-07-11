class Address < ApplicationRecord
  validates :house_number, presence: true
  validates :street_name, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :zip_5, presence: true, numericality: true, length: { is: 5 }

  def to_s
    street = [
      house_number, street_predirection, street_name, street_type,
      street_postdirection, unit_type, unit_number
    ].reject(&:blank?).join(' ')
    state_zip = [ state, zip_5 ].join(' ')

    [ street, city, state_zip ].join(', ')
  end
end
