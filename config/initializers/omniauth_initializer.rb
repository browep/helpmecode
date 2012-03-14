require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp'), :scope => "email"
  provider "windowslive", ENV['WINDOWS_LIVE_KEY'] || '0000000040095B38', ENV['WINDOWS_LIVE_SECRET'] || 'PQrdxh0kX5vXTsQ5xguL6iwVNEH0TzLI',
           :scope => 'wl.emails', :client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}
  provider :facebook, ENV['FACEBOOK_LIVE_KEY'] || '339786219390441', ENV['FACEBOOK_LIVE_SECRET'] || '6c89de2182af3924d9aa8afb4919dc40',
           :scope=>'email',:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}
end