require 'rails_helper'

RSpec.describe AddressVerification, type: :model do
  describe 'creation' do
    it 'can create a new address verification' do
      verification = AddressVerification.new(
        street_address: '275 W 10th Ave',
        city: 'Eugene', state: 'OR', zip_code: '97401'
      )

      expect(verification).to be_valid
    end

    it { is_expected.to validate_presence_of :street_address }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :state }
    it { is_expected.to validate_presence_of :zip_code }
    it { is_expected.to validate_length_of(:zip_code).is_equal_to(5) }
    it { is_expected.to validate_numericality_of :zip_code }
  end
end
