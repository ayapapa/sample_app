class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  # SessionsHelperをミックスイン
  include SessionsHelper

end
