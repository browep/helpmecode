# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Helpmecode::Application.initialize!

require "aws/s3"

# create an s3 object
AWS::S3::Base.establish_connection!(
    :access_key_id => ENV['S3_ACCESS_KEY_ID'],
    :secret_access_key => ENV['S3_SECRET_ACCESS_KEY']
)