require "aws/s3"

class UploadController < ApplicationController

  layout false

  include AWS::S3

  before_filter :is_owner, :only=>[:upload]

  def upload


    upload_obj = params[:upload]
    if upload_obj[:id] && upload_obj[:file] then
      upload_path = "tutorials/#{upload_obj[:id]}/#{upload_obj[:file].original_filename}"
      S3Object.store(upload_path,
                     upload_obj[:file].tempfile,
                     APP_CONFIG[:s3_bucket_main],
                     :access=>:public_read)

      @img_url = "http://s3.amazonaws.com/#{APP_CONFIG[:s3_bucket_main]}/#{upload_path}"

      render  :json => {
          'success' => true,
          'url' => @img_url
      }

    else
      render :json => {
          'success' => false,
          'data' => 'upload failure: need tutorial_id and newName params'
      }
    end

  end

  private
  def is_owner
    tutorial = Tutorial.find(params[:upload][:id])
    if !logged_in? || tutorial.user != current_user
      Rails.logger.error "access denied for #{params[:tutorial_id]}"
      redirect_to root_path, :notice => "You must be the owner of that tutorial to edit it."
    end
  end
end
