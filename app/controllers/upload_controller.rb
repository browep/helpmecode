require "aws/s3"

class UploadController < ApplicationController

  layout false

  include AWS::S3

  def upload


    if params[:tutorial_id] && params[:file] then
      upload_path = "tutorials/#{params[:tutorial_id]}/#{params[:file].original_filename}"
      S3Object.store(upload_path,
                     params[:file].tempfile,
                     APP_CONFIG[:s3_bucket_main],
                     :access=>:public_read)

      @img_url = "http://s3.amazonaws.com/#{APP_CONFIG[:s3_bucket_main]}/#{upload_path}"

    else
      render :json => {
          'success' => false,
          'data' => 'upload failure: need tutorial_id and newName params'
      }
    end

  end
end
