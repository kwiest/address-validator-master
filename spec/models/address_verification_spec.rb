require 'rails_helper'

RSpec.describe AddressVerification, type: :model do
  let!(:address) {
    AddressVerification.new(
      street_address: 'residential house',
      city: 'Eugene',
      state: 'OR',
      zip_code: '97401'
    )
  }

  it { is_expected.to validate_presence_of :street_address }
  it { is_expected.to validate_presence_of :city }
  it { is_expected.to validate_presence_of :state }
  it { is_expected.to validate_presence_of :zip_code }
  it { is_expected.to validate_length_of(:zip_code).is_equal_to(5) }
  it { is_expected.to validate_numericality_of :zip_code }

  describe '#new' do
    it 'can create a new address verification' do
      expect(address).to be_valid
    end
  end

  describe '#verify!' do
    it 'should raise an exception if the address is not valid' do
      invalid_address = AddressVerification.new
      expect{ invalid_address.verify! }.to raise_error(AddressVerification::VerificationError)
    end
  end

  describe '#deliverable?' do
    it 'should have deliverable addresses' do
      VCR.use_cassette :lob_deliverable_verification do
        address.verify!
        expect(address.deliverable?).to be(true)
      end
    end

    it 'should have undeliverable addresses' do
      VCR.use_cassette :lob_undeliverable_verification do
        address.street_address = 'undeliverable no match'
        address.verify!
        expect(address.deliverable?).to be(false)
      end
    end
  end

  describe '#to_address_paramsq' do
    it 'should build a hash to pass to Address' do
      expected_params = {
        house_number: '1709',
        street_name: 'BRODERICK',
        street_type: 'ST',
        street_predirection: '',
        street_postdirection: '',
        unit_number: '',
        unit_type: '',
        city: 'SAN FRANCISCO',
        state: 'CA',
        county: 'SAN FRANCISCO',
        zip_5: '94115',
        zip_4: '2525'
      }
      VCR.use_cassette :lob_deliverable_verification do
        address.verify!
        expect(address.to_address_params).to eq(expected_params)
      end
    end
  end
end
