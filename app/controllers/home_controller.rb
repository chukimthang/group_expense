class HomeController < ApplicationController
  def index
    per_page = params[:per_page] ? params[:per_page].to_i : Group::PAGE_SIZE
    page_index = 1

    unless params[:page].nil?
      page_index = params[:page].to_i
    end

    @groups = Group.page(page_index).per(per_page)
    @total_records = @groups.size

    @start_count = 1
    if page_index > 1
      @start_count = per_page * (page_index - 1) + 1
    end
  end

  def set_locale
    session[:locale] = params[:locale]
    redirect_to :back
  end
end
