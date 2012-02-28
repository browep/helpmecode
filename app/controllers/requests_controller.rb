class RequestsController < ApplicationController

  before_filter :login_required, :only => [:new,:create]

  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  def index
    @requests = Request.order("created_at DESC").all
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request])
    @request.user = current_user

    if @request.save
      redirect_to @request, :flash=> {success: 'Request was successfully created.'}
    else
      render :action => 'new'
    end
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    @request = Request.find(params[:id])
    if @request.update_attributes(params[:request])
      redirect_to @request, :flash=> {success: 'Request was successfully updated.'}
    else
      render :action => 'edit'
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to requests_url, :notice => "Successfully destroyed request."
  end
end
