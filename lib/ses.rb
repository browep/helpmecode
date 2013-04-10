class SES
  def initialize
    @ses = AWS::SES::Base.new(
        :access_key_id => ENV['S3_ACCESS_KEY_ID'],
        :secret_access_key => ENV['S3_SECRET_ACCESS_KEY']
    )
  end

  delegate :send_email, :to=>:ses
  attr_reader :ses
end