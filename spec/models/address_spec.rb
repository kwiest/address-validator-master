require 'rails_helper'

RSpec.describe Address, :type => :model do
  it { is_expected.to validate_presence_of :house_number }
  it { is_expected.to validate_presence_of :street_name }
  it { is_expected.to validate_presence_of :city }
  it { is_expected.to validate_presence_of :state }
  it { is_expected.to validate_length_of(:state).is_equal_to(2) }
  it { is_expected.to validate_presence_of :zip_5 }
  it { is_expected.to validate_length_of(:zip_5).is_equal_to(5) }
  it { is_expected.to validate_numericality_of :zip_5 }

  describe '#to_s' do
    let(:address) { create(:address_ny) }
    it 'prints out the address components needed for mailing together as a string' do
      expect(address.to_s).to eq('129 W 81st St Apt 5A, New York, NY 10024')
    end
  end
end
