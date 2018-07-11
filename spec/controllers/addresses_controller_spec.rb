require 'rails_helper'

RSpec.describe AddressesController, :type => :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) {
        {
          address_verification: {
            street_address: '1600 Pennsylvania Avenue NW',
            city: 'Washington',
            state: 'DC',
            zip_code: '20500'
          }
        }
      }

      it 'creates a new address' do
        VCR.use_cassette :lob_deliverable_verification do
          post 'create', params: valid_params
          expect(assigns(:address).house_number).to eq('1709')
          expect(assigns(:address).street_name).to eq('BRODERICK')
          expect(assigns(:address).street_type).to eq('ST')
          expect(assigns(:address).city).to eq('SAN FRANCISCO')
          expect(assigns(:address).state).to eq('CA')
          expect(assigns(:address).county).to eq('SAN FRANCISCO')
          expect(assigns(:address).zip_5).to eq('94115')
          expect(assigns(:address).zip_4).to eq('2525')
        end
      end
    end
  end
end
