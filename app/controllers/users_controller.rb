require 'util'

class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :show, :auth_callback]

  def new
    @user = User.new
  end

  def create
    if session[:new_user]
      @user = session[:new_user]
      @user.username = params[:user][:username]
    else
      @user = User.new(params[:user])
    end

    if @user.save

      # we dont want a save active record object in the session
      session.delete :new_user

      g_api = Gravatar.new(@user.email)
      avatar_url = g_api.image_url
      @user.avatar_url = avatar_url
      @user.save

      if session[:user_fullname]
        @user.profile.full_name = session[:user_fullname]
        @user.profile.save
      end

      session[:user_id] = @user.id
      redirect_to tutorials_path, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def auth_callback
    Rails.logger.debug "auth_callback: #{params}"
    auth_hash = request.env['omniauth.auth']
    third_party_uid = auth_hash['uid']
    third_party_provider = URI(third_party_uid).host || auth_hash['provider']
    user_email = auth_hash['info']['email'] || auth_hash['extra']['raw_info']['emails']['preferred']
    user_fullname = auth_hash['info']['name']

    # check for that uid, then the email

    user = User.find_by_third_party_uid(third_party_uid)
    user = User.find_by_email(user_email) unless user

    if user
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, :notice => "Logged in successfully."
    else
      # we dont know this user, put these credentials in the session, ask to create a new one
      @new_user = User.new(:email=>user_email,:third_party_uid=>third_party_uid,:third_party_provider=>third_party_provider)
      session[:new_user] = @new_user
      session[:user_fullname] = user_fullname
      @proposed_username = Util.email_to_proposed_username user_email
    end
  end

end
