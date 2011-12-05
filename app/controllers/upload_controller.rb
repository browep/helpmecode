require "aws/s3"

class UploadController < ApplicationController

  layout false

  include AWS::S3

  def upload


    if params[:tutorialId] && params[:newName] then
      upload_path = "tutorials/#{params[:tutorialId]}/#{params[:newName]}"
      S3Object.store(upload_path,
                     params['handle'].tempfile,
                     APP_CONFIG[:s3_bucket_main],
                     :access=>:public_read)

      @img_url = "http://s3.amazonaws.com/#{APP_CONFIG[:s3_bucket_main]}/#{upload_path}"

    else
      render :json => {
          'success' => false,
          'data' => 'upload failure: need tutorialId and newName params'
      }
    end

  end
end
