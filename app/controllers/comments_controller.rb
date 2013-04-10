require 'ses'

class CommentsController < ApplicationController

  before_filter :login_required, :only => [:new,:create]
  before_filter :is_owner, :only=>[:edit,:update,:destroy]

  include ApplicationHelper

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user

    # get the owner of the tutorial
    user = @comment.tutorial.user
    ses = SES.new

    mail_args = {:to => user.email,
            :from => APP_CONFIG[:system_notification_email],
            :subject => "You have a new comment on \"#{@comment.tutorial.title}\"",
            :text_body => "You have a new comment on \"#{@comment.tutorial.title}\".  Click the link to go to the tutorial. http://#{APP_CONFIG[:domain]}#{tutorial_slug @comment.tutorial} .  -Paul from the helpmeco.de team."}
    resp = ses.send_email(
        mail_args
    )

    Rails.logger.info "email sent: #{mail_args}, resp: #{resp}"

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.tutorial, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment.tutorial, notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.tutorial, :notice => "Comment deleted" }
      format.json { head :ok }
    end
  end

  private
  def is_owner
    comment = Comment.find(params[:id])
    if !logged_in? || comment.user != current_user
      redirect_to root_path, :notice => "You must be the owner of that comment to edit it."
    end
  end

end
