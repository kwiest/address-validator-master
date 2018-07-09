require 'rails_helper'

RSpec.describe AddressesController, :type => :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) {
        {
          street_address: '1600 Pennsylvania Avenue NW',
          city: 'Washington',
          state: 'DC',
          zip_code: '20500'
        }
      }
      before do
        post 'create', params: valid_params
      end
      it 'creates a new address model with the house number saved' do
        expect(assigns(:address).house_number).to eq '1600'
      end

      it 'creates a new address model with the street name saved' do
        expect(assigns(:address).street_name).to eq 'Pennsylvania'
      end

      it 'creates a new address model with the street name saved' do
        expect(assigns(:address).street_type).to eq 'Avenue'
      end

      it 'creates a new address model with the street post direction saved' do
        expect(assigns(:address).street_postdirection).to eq 'NW'
      end

      it 'creates a new address model with the city saved' do
        expect(assigns(:address).city).to eq 'Washington'
      end

      it 'creates a new address model with the state saved' do
        expect(assigns(:address).state).to eq 'DC'
      end

      it 'creates a new address model with the zip_5 saved' do
        expect(assigns(:address).zip_5).to eq '20500'
      end
    end
  end
end
