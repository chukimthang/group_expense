# :nodoc:
class ApplicationController < ActionController::Base
  # before_action :set_gettext_locale
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  check_authorization :unless => :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
