require "aws/s3"

# create an s3 object
AWS::S3::Base.establish_connection!(
    :access_key_id => APP_CONFIG[:S3_ACCESS_KEY_ID],
    :secret_access_key => APP_CONFIG[:S3_SECRET_ACCESS_KEY]
)