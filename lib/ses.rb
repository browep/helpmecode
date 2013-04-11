class SES
  def initialize
    @ses = AWS::SES::Base.new(
        :access_key_id => APP_CONFIG[:S3_ACCESS_KEY_ID],
        :secret_access_key => APP_CONFIG[:S3_SECRET_ACCESS_KEY]
    )
  end

  delegate :send_email, :to=>:ses
  attr_reader :ses
end