class HomeController < ApplicationController
  def blank_page
  end

  def set_locale
    session[:locale] = params[:locale]
    redirect_to :back
  end
end
