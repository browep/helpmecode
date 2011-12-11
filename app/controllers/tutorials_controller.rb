class TutorialsController < ApplicationController

  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  before_filter :login_required, :only=>[:new,:create]
  before_filter :is_owner, :only=>[:edit,:destroy]

  # GET /tutorials
  # GET /tutorials.json
  def index

    @tag = params[:tag]
    query = @tag ? Tutorial.tagged_with(@tag) : Tutorial
    @tutorials = query.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tutorials }
    end
  end

  # GET /tutorials/1
  # GET /tutorials/1.json
  def show
    if(params[:id])
      @tutorial = Tutorial.find(params[:id])
    elsif params[:year] && params[:month] && params[:title]
      @tutorial = Tutorial.find_by_slug("#{params[:year]}/#{params[:month]}/#{params[:title]}")
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tutorial }
    end
  end

  # GET /tutorials/new
  # GET /tutorials/new.json
  def new
    @tutorial = Tutorial.new
    @tutorial.user = current_user
    if @tutorial.save
      redirect_to edit_tutorial_path(@tutorial)
    else
      redirect_to root_url, :notice => "Error creating a new tutorial"
    end

  end

  # GET /tutorials/1/edit
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  # POST /tutorials
  # POST /tutorials.json
  def create
    @tutorial = Tutorial.new(params[:tutorial])

    @tutorial.user = current_user

    respond_to do |format|
      if @tutorial.save
        format.html { redirect_to @tutorial, notice: 'Tutorial was successfully created.' }
        format.json { render json: @tutorial, status: :created, location: @tutorial }
      else
        format.html { render action: "new" }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tutorials/1
  # PUT /tutorials/1.json
  def update
    @tutorial = Tutorial.find(params[:id])

    respond_to do |format|
      if @tutorial.update_attributes(params[:tutorial])
        url = "/" + Tutorial.get_slug(@tutorial)
        format.html { redirect_to(url , notice: 'Tutorial was successfully updated.' )}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutorials/1
  # DELETE /tutorials/1.json
  def destroy
    @tutorial = Tutorial.find(params[:id])
    @tutorial.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user), :notice => "Tutorial \"#{@tutorial.title}\" has been deleted." }
      format.json { head :ok }
    end
  end

  private
  def is_owner
    tutorial = Tutorial.find(params[:id])
    if !logged_in? || tutorial.user != current_user
      redirect_to root_path, :notice => "You must be the owner of that tutorial to edit it."
    end
  end
end
