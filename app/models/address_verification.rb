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


  private

  def lob_client
    @lob_client ||= Lob::Client.new(api_key: ENV['LOB_SECRET_API_KEY'])
  end
end
