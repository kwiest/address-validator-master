class AddressVerification
  class VerificationError < StandardError; end

  include ActiveModel::Model

  attr_accessor :street_address, :city, :state, :zip_code
  attr_reader :verification

  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true,
    numericality: true,
    length: { is: 5 }

  def verify!
    raise VerificationError.new('Cannot verify an invalid address') unless valid?
    @verification = lob_client.us_verifications.verify(
      primary_line: street_address,
      city: city,
      state: state,
      zip_code: zip_code
    )
  end

  def deliverable?
    verification['deliverability'] == 'deliverable'
  end

  def to_address_params
    {
      house_number: verification['components']['primary_number'],
      street_name: verification['components']['street_name'],
      street_type: verification['components']['street_suffix'],
      street_predirection: verification['components']['street_predirection'],
      street_postdirection: verification['components']['street_postdirection'],
      unit_number: verification['components']['secondary_designator'],
      unit_type: verification['components']['secondary_number'],
      city: verification['components']['city'],
      state: verification['components']['state'],
      county: verification['components']['county'],
      zip_5: verification['components']['zip_code'],
      zip_4: verification['components']['zip_code_plus_4']
    }
  end


  private

  def lob_client
    @lob_client ||= Lob::Client.new(api_key: ENV['LOB_SECRET_API_KEY'])
  end
end
