class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  helper :layout

end
