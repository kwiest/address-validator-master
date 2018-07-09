FactoryBot.define do
  factory :address do
    # 129 W 81st St Apt 5A, New York, NY 10024
    factory :address_ny do
      house_number '129'
      street_predirection 'W'
      street_name '81st'
      street_type 'St'
      unit_type 'Apt'
      unit_number '5A'
      city 'New York'
      state 'NY'
      zip_5 '10024'
    end
  end
end
